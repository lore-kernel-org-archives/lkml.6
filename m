Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-465683-1517522406-2-5331112164681778507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517522405; b=j8gMRiqDqoHAFI5Te3NAOkqIwmqrYgrMEFp4np+S2TMctKk
    LBt2Jwy0Cn4Tu764wLqRJAk/h4FpdtHKc4bROfic+WjpvwgMbLEdO4nJz3uj2RIK
    yQizo89fi5h1Nws3tX0tcIr7+ZqrIqN1hlecRwYyE+fHeEUHsG/7N8IWHVETthpW
    nCkcwSBdfaDy5WulovUSW04hMirHNq06ODbN0KiviDCffAkjl/af9fsDDSvST28w
    SrWDEKybk3WjDl8qgwn25R2nVwJphjZtbju51mnIA+k16XrdTpiQtCwQz8keVXJP
    GTlXbzTG5AiXjFBhH+8uYQXCaLZv8bu9ux+1fbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517522405; bh=M5Vn3/k/cXI+HEvlvFH3pHyGy0Err51KBeAr2B
    j/BJ8=; b=qcFcJUnYFwaPYMf/Dt8DX00U/2D2ciok0BcAmqhEegVmhrXMFSgNmX
    QSu2qs/W30elPWTLD565wing9p0+R+jLabtUqe5AJ7tBzGQUObzDTZVOfW5iIZqk
    FWmrKn5NvJ4RTCKI8jEE+vRuIg61U+z4Ygpa0AP45l/dRsUWyskS+VwVrsteDeJH
    SsoPSdOPxtRjM5azIbzy+XV8HC/KgXWvFnVV7uwyN+ua+kXNLvUo5ga4Cp8JkwxS
    V0oviy71t1qFhUilOB6UCCGpM2c3SCT6m+zfJOHhSIP00Lgb40l9Jr1HavyaGbHi
    v35Imh8iHzhypHbvaKPC1ci8lcUyIq3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeBAWAE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 17:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeBAWAD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 17:00:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5B217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x226qqKcVb/xcX0QZCT5F1zc4ym6tq1id/D/kxR1hVfoGYEe01vI68teEkrLOCGnjMGszpJz+cq3VWRd7NEtH+Yc=
MIME-Version: 1.0
In-Reply-To: <20171206053015.GA19023@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-9-git-send-email-hao.wu@intel.com> <f5ae8e5edf88420e89cfbe754407b92e@AcuMS.aculab.com>
 <20171128031519.GA25705@hao-dev> <CANk1AXRBEcz5_j+v0oTAXfH10hrPbHGabdR8Pqt07exYxYgfCw@mail.gmail.com>
 <20171205033330.GA19730@hao-dev> <CANk1AXRdU6usqtsCUjjSC8Fk2SS8iKn+Ow4PvCiRpSBAcDwWjw@mail.gmail.com>
 <20171206053015.GA19023@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Feb 2018 15:59:21 -0600
X-Gmail-Original-Message-ID: <CANk1AXS6xa8FTBTk5Q2PWcijb1Uuy=XFAFFin-R2dU2y-iruvw@mail.gmail.com>
Message-ID: <CANk1AXS6xa8FTBTk5Q2PWcijb1Uuy=XFAFFin-R2dU2y-iruvw@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] fpga: add Intel FPGA DFL PCIe device
To: Wu Hao <hao.wu@intel.com>
Cc: David Laight <David.Laight@aculab.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "luwei.kang@intel.com" <luwei.kang@intel.com>,
        "yi.z.zhang@intel.com" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Dec 5, 2017 at 11:30 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Tue, Dec 05, 2017 at 11:00:22AM -0600, Alan Tull wrote:
>> On Mon, Dec 4, 2017 at 9:33 PM, Wu Hao <hao.wu@intel.com> wrote:
>> > On Mon, Dec 04, 2017 at 01:46:59PM -0600, Alan Tull wrote:
>> >> On Mon, Nov 27, 2017 at 9:15 PM, Wu Hao <hao.wu@intel.com> wrote:
>> >> > On Mon, Nov 27, 2017 at 10:28:04AM +0000, David Laight wrote:
>> >> >> From: Wu Hao
>> >> >> > Sent: 27 November 2017 06:42
>> >> >> > From: Zhang Yi <yi.z.zhang@intel.com>
>> >> >> >
>> >> >> > The Intel FPGA device appears as a PCIe device on the system. This patch
>> >> >> > implements the basic framework of the driver for Intel PCIe device which
>> >> >> > is located between CPU and Accelerated Function Units (AFUs), and has
>> >> >> > the Device Feature List (DFL) implemented in its MMIO space.
>> >> >>
>> >> >> This ought to have a better name than 'Intel FPGA'.
>> >> >> An fpga can be used for all sorts of things, this looks like
>> >> >> a very specific architecture using a common VHDL environment to
>> >> >> allow certain types of user VHDL be accessed over PCIe.
>> >> >
>> >> > Hi David
>> >> >
>> >> > This patch adds a pcie device driver for Intel FPGA devices which implements
>> >> > the DFL, e.g Intel Server Platform with In-package FPGA and Intel FPGA PCIe
>> >> > Acceleration Cards. They are pcie devices, and all have DFL implemented in
>> >> > the MMIO space, so we would like to use one kernel driver to handle them.
>> >> >
>> >> > With this full patchset, it just provides user the interfaces to configure
>> >> > and access the FPGA accelerators on Intel DFL based FPGA devices. For sure,
>> >> > users can develop and build their own logics via tools provided by Intel,
>> >> > program them to accelerators on these Intel FPGA devices, and access them
>> >> > for their workloads.
>> >>
>> >> I don't see anything Intel specific here.  This could all be named dfl-*
>> >
>> > The maybe some device specific things, e.g Intel FPGA devices supported by this
>> > driver always have FME DFL at the beginning on the BAR0 for PF device.

I'm thinking that another user could add their PCI id's and a static
FPGA image that has a DFL in the right place for this to work for
them.

>> >
>> > But I think this should be the right direction for better code reuse, it could
>> > save efforts for other vendors who want to use DFL and follow the same way.

I appreciate your understanding here.

>> >
>> > Thanks for the comments. I will rename this driver in the next version.
>>
>> Thanks!
>>
>> Regarding file names, it seems like the files added to drivers/fpga
>> could be uniformly named dfl-*.[ch].  Some are fpga-dfl-*.[ch] while
>> other are currently dfl-*.[ch] currently.
>
> Sure, will have all related drivers files renamed to dfl-*.[ch].

Actually, I'll reverse that a bit.  The enumeration code, including
the pcie part is all sufficiently general to run on anything that has
a DFL struct located in the right place.  But individual feature
drivers (currently only the fme-mgr) will be vendor specific and could
be named intel-*.

Alan
