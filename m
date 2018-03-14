Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-342653-1520992820-2-12134401873789674672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520992819; b=FJONNiyKHA46NGDA+pI89b3RkigcYxKj7Xt7ebXaBP2T9Sc
    v2e7Ed4f6h+1bvm1LNHzcde2psGu1jHcggv6AxXJJxw32JNG47lIsTKJ5Xp69LvZ
    7qafRs1ahLwmr3ZvNaSemgCa7UJfnceAF8En8KTFFqNw/V6K9ZT8tkVcfKjBYDOC
    Y0O1d/6m4Z1AI/c/brITRc6kWKYNHyO13/dk9qlZgaHgncYJVYfGIUSrF9E9x764
    JEMntAxqUA+Onj5QjYVgzM60rqW1tUlZe0Ew5S9hU8Fqi47VFl0J72T9EX7qj5yp
    4D+drO460dTqaT01mXbl+0P/2kplRhxiXQ09MtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520992819; bh=2qRPV
    Q5yBaocdUGMyoGwHQl6otXSeSCPDqOeKFqtMrM=; b=K+h8zqRVb3Ee87gmtYrhJ
    EEjUO1+hNFC40wLgI3+oZyA14YTzq03wTl9x6XAvkc466rGY39VxSKf4J2Th4Wi0
    iKG5T66kvpOU81J+MxaVW+goFIaxeKCoYaJw+dHxJG9n/Xn4egx/uZykdLpXLBht
    P6kUvnhT67OKyEVfSgfVrs3giet5/J0wedcsLoIZngF77A0f9arB1p3oyjDgh3gI
    3gWIFuyldQKytLIzAWTHRqnN2rjYuja7m3NklP7aTMvx0NEPMSs5T3EWpXaxz05/
    Kd9ZnWXUVRMAb+DP5IDHo2XqzbmYI41w1h2PK5qi8HE9iZ3MlxXWBCRKLaNdlV9q
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CwpQP76i;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CwpQP76i;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeCNCAQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 22:00:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43591 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932782AbeCNCAO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 22:00:14 -0400
X-Google-Smtp-Source: AG47ELuRPwYR4sIy21nttnzJdDNBtb3JJLIwJlMpULdNJKK5+hmnfoL7g/SxC9qmUhIn4el1RFbe3w==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v6] usb: core: Add "quirks" parameter for usbcore
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180313113654.GA3304@bombadil.infradead.org>
Date: Wed, 14 Mar 2018 10:00:07 +0800
Cc: Greg KH <gregkh@linuxfoundation.org>, fengguang.wu@intel.com,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3823E1D9-FAC0-4816-AF04-5B944C5A6504@canonical.com>
References: <20180313072619.29717-1-kai.heng.feng@canonical.com>
 <20180313113654.GA3304@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 13, 2018 at 03:26:19PM +0800, Kai-Heng Feng wrote:
>> +	usbcore.quirks=
>> +			[USB] A list of quirks entries to supplement or
>> +			override the built-in usb core quirk list.  List
>> +			entries are separated by commas.  Each entry has
>> +			the form VID:PID:Flags where VID and PID are Vendor
>> +			and Product ID values (4-digit hex numbers) and
>> +			Flags is a set of characters, each corresponding
>> +			to a common usb core quirk flag as follows:
>
> This doesn't really tell me that the specified quirks will be XORed with
> the built-in quirks.  Maybe something like ...
>
> 			[USB] A list of quirk entries to augment the
> 			built-in usb core quirk list.  List entries are
> 			separated by commas.  Each entry has the form
> 			VendorID:ProductID:Flags.  The IDs are 4-digit hex
> 			numbers and Flags is a set of letters.  Each letter
> 			will change the built-in quirk; setting it if it is
> 			clear and clearing it if it is set.  The letters
> 			have the following meanings:

Thanks, will update the description to specify the XOR behavior.

>
>> +		/* Each entry consists of VID:PID:flags */
>> +		field = strsep(&p, ":");
>> +		if (!field)
>> +			break;
>> +
>> +		if (kstrtou16(field, 16, &vid))
>> +			break;
>> +
>> +		field = strsep(&p, ":");
>> +		if (!field)
>> +			break;
>> +
>> +		if (kstrtou16(field, 16, &pid))
>> +			break;
>
> Is there a reason to not use sscanf here like hid-quirks.c does?

Actually I use sscanf in previous patch version. Using kstrto* isn't needed  
anymore, I'll use sscanf in next version.

Kai-Heng


