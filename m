Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBWQNo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:13:44 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:37429 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeBWQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:13:43 -0500
X-Google-Smtp-Source: AG47ELub9QASEXIrKsF7zVwgzXNA/MrTaoRl6QL7X88yR7g1jwGLyeNjOs+H1iTuLuOTIvN9APRSfeIzCLxX99zcRRk=
MIME-Version: 1.0
In-Reply-To: <CAHp75VdAsEQNKRnTRKnpY+X2Ph=B17dNQ_1==2OkRKcs7ma5KA@mail.gmail.com>
References: <20180223153700.2186058-1-arnd@arndb.de> <CAHp75VdAsEQNKRnTRKnpY+X2Ph=B17dNQ_1==2OkRKcs7ma5KA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:13:41 +0200
Message-ID: <CAHp75VdpwSoGiDze7HMWCxXZcmT_MdkBPDyYyP-G3CAQjoO0Lw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:59 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> IIRC memcpy_toio() doesn't increment the destination address.
>
> lo_hi or hi_lo helpers sound better.

Ah, sorry, I messed up with writesl() / etc.

memcpy_toio() has another side-effect, but here it seems unimportant.

-- 
With Best Regards,
Andy Shevchenko
