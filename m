Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeFAPYE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:24:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37554 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFAPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:24:01 -0400
X-Google-Smtp-Source: ADUXVKISEHuqbmk8NWy9y9CAxfuErAwx2TExguqvDUk9Y5Yrmevr5TuGLd1OKp9WbbxWEJPjFTtbWxOHp1H4o6CZ7uM=
MIME-Version: 1.0
In-Reply-To: <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com> <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 18:24:00 +0300
Message-ID: <CAHp75VdTyvQOqnSm67Uo5heP1otE98BbquM0TjSAorEzTgUwHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>, Ram Pai <linuxram@us.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 6:06 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/1/2018 11:02 AM, Andy Shevchenko wrote:
>> On Wed, May 30, 2018 at 7:34 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> Move early dump functionality into common code so that it is available for
>>> all archtiectures. No need to carry arch specific reads around as the read
>>> hooks are already initialized by the time pci_setup_device() is getting
>>> called during scan.
>>
>>>  /* If set, the PCIe ATS capability will not be used. */
>>>  static bool pcie_ats_disabled;
>>>
>>> +bool pci_early_dump;
>>> +
>>
>> I didn't check above these, but maybe a good idea to add one line
>> comment what is this about?
>
> This was discussed here:
>
> https://www.spinics.net/lists/linux-pci/msg72859.html

I understand what is it. What I'm pointing is the variable in the
source without any comment. In the context you have in diff previous
one has a comment.


-- 
With Best Regards,
Andy Shevchenko
