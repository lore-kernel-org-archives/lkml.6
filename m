Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654586-1521695770-2-1225633166085569458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521695769; b=ersxysiacupkyUFFgbhb/IwQLYZ82RlSnL37KxtH8YZgSdc
    ZYkyoWEZ09YbMU/D4adGrMnKuZmBoIJg9tlVeHeuZp/KCDyy8Htf/C9n3AdBqUe/
    Xy5oOVdk2h1s2Ak0K0g/1Lj1Gr69V3frChD5N4E7NAg21Yv6B6VK3UoGlN2VnM/7
    gjZlrCK0ZQkovD0t1W6lr4svyRZe5bD5WRYVmMVIb8GAxEPveBybDhqm4ZG8VP9O
    nn0gVm7kXqz6+1z36jWu2ICOTO21QK9HrGNg0/lLuj9Pd6wGf8fwLpvwXv5ehmC3
    7lLvci+hO+aX/kmJydj8xy4RJQWuMdz2NXXLaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521695769; bh=vFDRzWT/eyftJ9poA1EPKopuCwQX1nfFEgmh4sww/YY=; b=O
    WfdGc9sdKUbHm45dl8Q+FSxN+M5tfXsb/FG3XagiHklYtc3Ye/MjbkIFtASObcN6
    cDnow6OO+Obqwd4xbLAkLOaJ/mgZ2FdBaf9ec2sxUGdEo4XxZeCxcWAVSFsN2I/w
    5SFtzr7jVV8YoIQDx3ijTg/JDJysoWiaMDVXuJcXI0X+QnIhjn688j2n9rDeQ2Ir
    iEafn3tlAf5DAIm9hC75eIE96LCUmzkm6Yxt2+DZjdJIUhr1PGARpO3EzwYLg9E1
    tgK7ejdXJETX6uVRRZ2sB7uYeuvZkwqeh0P8OjxH36HnVTBOfBPLLlqBAGdb3Mkn
    ceP0FDbDE5UDuB1KZ5ghQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCVFQG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 01:16:06 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:47066 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752042AbeCVFQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 01:16:06 -0400
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Steve French <smfrench@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Backlund <tmb@mageia.org>,
        =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
References: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com>
 <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu>
 <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com>
 <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
 <20180316133241.GC11397@kroah.com>
 <CAH2r5mvYxpr_0CPZNiNJTGhFNaM06w-EoTT7WS8oVjVZq8HCCw@mail.gmail.com>
 <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
Message-ID: <46a98623-2125-1f16-c456-db06f015f95a@csail.mit.edu>
Date: Wed, 21 Mar 2018 22:15:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/21/18 10:12 PM, Srivatsa S. Bhat wrote:
> On 3/21/18 7:02 PM, Steve French wrote:
>> Found a patch which solves the dependency issue.  In my testing (on
>> 4.9, with Windows 2016, and also to Samba) as Pavel suggested this
>> appears to fix the problem, but I will let Srivatsa confirm that it
>> also fixes it for him.  The two attached patches for 4.9 should work.
>>
> 
> Indeed, those two patches fix the problem for me on 4.9. Thanks a lot
> Steve, Pavel and Aurelien for all your efforts in fixing this!
> 
> I was also interested in getting this fixed on 4.4, so I modified the
> patches to apply on 4.4.88 and verified that they fix the mount

I meant to say 4.4.122 there (the latest stable 4.4 version at the moment).

Regards,
Srivatsa
VMware Photon OS
