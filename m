Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3015022-1525596746-2-9770794984004861116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525596746; b=myWwp1cAykwsrrX0GecqgD/i1qSSw1B5VxgEtmVQD2L9rdBR6j
    UfmF8huzY/QTbgph6dPaTSLoqwGUPX8HZA9NFsPLrbLipE1/o//EdYQhCnmvG8Vn
    pePclpF5BNYjEvf120RhRvnRL8fBKXhJAM7ndLIvW88jnIcMz05wsI0oF8QyqpeG
    t/e/j8em7cxgvoTy1Lgqck4nF9/YduQEovUXGGjY5rrQEoqgHF4BMnAlAMzTIgpJ
    ascu0Dki7+QBso8J0kQaDXDcrkukFjCuf/EJxlXH14etHtogU6+rYbcT6+GbXCB1
    1R1S6bQPRV+7eZOwM+d3hKgatk/Pf9tfjCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525596746;
    bh=hZKurHSq4sIsboziEwzuKlOe95DDtA/+gLjDHY5/iA4=; b=FGgWZZ7ydAl2
    uoTx73BPSMn4B9OxUJcr3jOZdqO8eKhjmO6NVlLQUafRRKQXdnP2FJGexrAa0e0J
    NnpdliMIhvp8dT9kY5AOQUvNUrJVPJgGzvQJ2l4XOrRm6BSSNlTJkUNYFY35k8O8
    br5H/NGTtlEubWNmsVejzIO+ONi1Lq1AuxvbCpzsYOU25SOSajhONH8l69KvyIeT
    p9Mhtw/ebtl1AfQghghCCF9lQIUMwUVnQQ7Bx81dmQweVKZg4acKgeSGqn+K8t7G
    xXk3TCBJ5Aa5kbfeDVsFPDoeKF3ZCH5jJiLWe6DfwmB5FeM7BpOgpgSrR5jJEOaQ
    aTGpDxHVnw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=physik.fu-berlin.de header.result=pass
    header_org.domain=fu-berlin.de header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=physik.fu-berlin.de header.result=pass
      header_org.domain=fu-berlin.de header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK+IOVPD5ZqTiCRPYJK8gUchzVINFtEEVy22E9GNiDFHqEBcY6p0wLPADdevq/1NTdmAsWHTI5rQABJ6pDFib4w8DaDrEhhVvHX0N68jDBOaGCDYac7/
    jyDDBVSnxdB2kKOGOf8wN8gNbe5X05pLHtXmpZjSNefP0pdC7T5UiK7swR0JHE4tHjfXmjKTJp/CN5/0y68cQRBscRzQ8DBeT3puXY2yxvq7nYGmsFmUAZNM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=orxY2vmOfUYA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=xNf9USuDAAAA:8 a=PyfqVzGwZDm3KFMkZQ4A:9 a=QEXdDO2ut3YA:10
    a=SEwjQc04WA-l_NiBhQ7s:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeEFIwP (ORCPT <rfc822;linux@kroah.com>);
        Sun, 6 May 2018 04:52:15 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:46162 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750872AbeEFIwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 May 2018 04:52:14 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: jdow <jdow@earthlink.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc: Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <7a997bb7-7f1c-e8b4-667c-3993f1d82e7c@earthlink.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f8a044e8-01b0-7008-49ac-7e9c5ce7defd@physik.fu-berlin.de>
Date: Sun, 6 May 2018 10:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7a997bb7-7f1c-e8b4-667c-3993f1d82e7c@earthlink.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 85.182.115.218
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 03:26 AM, jdow wrote:
> And before I forget there are two features of the RDBs that I heartily recommend never implementing on Linux. They were good ideas at the time; but, times
> changed. The RDBs are capable of storing a filesystem driver and some drive init code for the plugin disk driver card. That is giving malware authors entirely
> goo easy a shot at owning a machine. Martin S., I would strongly suggest that going forward those two capabilities be removed from the RDB readers in AmigaOS
> as well as Linux OS.

I assume removing the feature for AmigaOS isn't really possible since we don't have
the source code for that, do we?

Also, if I remember correctly, Mac partitions can store filesystem drivers as well
and its actually a feature being used in MacOS. parted received a patch some time
ago to fix the correct handling for storing the filesystem driver in the partition
table.

I would be generally against removing these features as I don't think the security
risk is relevant for the majority of users. The Amiga is a hobbyist machine these
days and AmigaOS has certainly way more on than way to be compromised through
vulnerabilities.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
