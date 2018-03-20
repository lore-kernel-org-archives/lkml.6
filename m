Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2022467-1521569881-5-1945988841198299011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521569881; b=f34QxqAvtodW7kgSCoO4LBD7gF8mVGdvUROPGpaBCqSkxl8
    UvF3+8nSLNh6+/7DZsTTIA9PrxnX+3kb0dECsTMe/MsJadTFrk4YcLPXGgxLOxff
    Rn82eHCRavBI5nyJndHExUVAKOiJtF2G9RAH3Itmp38EFdwHYsPndJJ7EUzEBO3z
    vkipXB5JUHQoiiNEjSdLzvJmBRPFKxU+Ae0yxablmkxX2tu40oLJO46sQMQWxETE
    7Ihw5mykE5h5QJd6fWuPFe4Wip8/9fJW/nXEbBVQOHD5A2LcwehrRbbm4aaNbGgd
    M9wWhNq75eFw+M8mUWBEGeaDQrv0MJlbvvcpn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521569881; bh=wH2oMvvyD2EnH9r6ZkJjRc+GfKCqlIlen8HATM
    zdAfk=; b=YtthMJheuAkXGeOqFVpOk0Hkk6lEu84xT7j07Lgg5llY+UvsjwPUPi
    pNHECaZrO0TgsCZhuoBLGeuLvuN6/Dj7Zuj2gys9FLOXBB3At9yTv3Xba0hF4P8e
    GlzoehmGHTNOrmUuRJsx9gjkwL4ZMFu1W15/eTGvXPcHADlq5YI+8SHP9NydTU2Z
    3+xKLp9XV5gnV7GAOh6Nb6InvVW3eoP/TJjAJnZKxh7Ubqg32syIN0rttIazfAJn
    2aghiQhdOR84eYe4D5LajNaEhVQJ6J+5km9KOHy2zyYt8Wf7bG0ADOpNW5z5ly/c
    l+qJD9svW1NTa82jqSRz1JXb0G4k2CcA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeCTSR5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 14:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSR4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 14:17:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B51F217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELtjprC1pb24B3RcRHUMv4tnvj7pHJXw99EReKp9cBb4W+vJrna+024wQ21DdU3aRAGeanwTRXwVDiROxsEcHFM=
MIME-Version: 1.0
In-Reply-To: <20180320071037.GB31239@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-24-git-send-email-hao.wu@intel.com> <CANk1AXQpPXhNoPt1Uj=YvbtO+jun7e2Yzvyp+wuR1ZXx6+-i8Q@mail.gmail.com>
 <20180320071037.GB31239@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Mar 2018 13:17:14 -0500
X-Gmail-Original-Message-ID: <CANk1AXRqfiWCDEo31-QGoKdUQ6PCjHH69LkuZdjErgGA-qxbiQ@mail.gmail.com>
Message-ID: <CANk1AXRqfiWCDEo31-QGoKdUQ6PCjHH69LkuZdjErgGA-qxbiQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/24] fpga: dfl: afu: add user afu sub feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 2:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, Mar 19, 2018 at 03:10:28PM -0500, Alan Tull wrote:
>> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
>>
>> Hi Hao,
>>
>> > From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> >
>> > User Accelerated Function Unit sub feature exposes the MMIO region of
>>
>> Is it 'user accelerated'?  I think it is the Accelerator interface.
>
> Hi Alan,
>
> This is only used to emphasize this is the interface to accelerator
> exposed to user. But looks like this causes some confusions for user
> actually from the description. I agree with you, that I will remove
> this UAFU from this patchset.
>
>>
>> > the AFU. After valid green bitstream (GBS) is programmed and port is
>>
>> Would it make sense to just use "partial bitstream" or "PR bitstream"
>> and "static bitstream" for this patchset?  I don't think that adding
>> this terminology makes things clearer.  In any case when someone else
>> uses this patchset, they may not be using this type of branding in
>> their terminology.
>
> Sure, will update the commit message and also sysfs doc below.

Yes and dfl.txt and the rest of the patchset as well, please.

Alan
