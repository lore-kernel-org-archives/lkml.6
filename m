Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeBUTAz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:00:55 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34581 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeBUTAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:00:53 -0500
X-Google-Smtp-Source: AH8x225fvAHI3fPQwEe5nsAyNffn18Ig2xc517PohgDJh70nzSy1zrcGsmMhAoQo5etT6oarQXY1R+1wnIJmBCpKC0E=
MIME-Version: 1.0
In-Reply-To: <20180221124707.26308-2-embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de> <20180221124707.26308-2-embedded24@evers-fischer.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:00:51 +0200
Message-ID: <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
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

On Wed, Feb 21, 2018 at 2:47 PM, Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:

> This commit decreases the number of jump labels and ensures
> that the next commit doesn't increase the number of occurrences
> of 'kfree(func_name)'.

> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1

First of all, this shouldn't be here.

> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>

Looks like bipolar disorder?

To the topic.
This is a slow path and your change makes code slightly less readable
b/c of patterns used in the kernel.

-- 
With Best Regards,
Andy Shevchenko
