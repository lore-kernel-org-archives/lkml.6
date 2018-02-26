Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeBZTMM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:12:12 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:44930 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBZTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:12:10 -0500
X-Google-Smtp-Source: AG47ELvaL02aLSz6bB4O+WIk752gZ+UJLD/8+2IZe0eiFdIMi/SrTks60yEBeRN8ob9DuW0gl2Rn4QUb9Ku7c3fkASs=
MIME-Version: 1.0
In-Reply-To: <20180226171617.10016-3-embedded24@evers-fischer.de>
References: <20180226171617.10016-1-embedded24@evers-fischer.de> <20180226171617.10016-3-embedded24@evers-fischer.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 21:12:08 +0200
Message-ID: <CAHp75VcYas_2i8r1G1J=DXnwmor_4tbWm0GZtP_VorVMK1vKpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: endpoint: Fix kernel panic after put_device()
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 7:16 PM, Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>
> 'put_device()' calls the relase function 'pci_epf_dev_release()',
> which already frees 'epf->name' and 'epf'.
>
> Therefore we must not free them again after 'put_device()'.

>  put_dev:
>         put_device(dev);
> -       kfree(epf->name);
> +       return ERR_PTR(ret);

Ouch, if it's double free (sounds like it is) it should be fixed up to
initial commit which brought that.
Thus, Fixes tag would be good to see.

-- 
With Best Regards,
Andy Shevchenko
