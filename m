Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848192081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3eSx5FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848192081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeLJXcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:32:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeLJXcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EtOtxKiOL45ufi6xOH0+jeDsJSuSiVvAjcb5eqcsNxc=; b=Y3eSx5FQk1qy4TOLoJ70RtEhO
        LHNl+/GHpbnkfHHD0/YD05EFjaFdrnF3oXQ9j+pF/M/1nJifCuN81SIzSRpidIjWfXtj17M8kzMBO
        4u6vLQdILJ7oxzkJcyrGeLcT7x22kA2hzbAnZaTYlY8f1GIar1MWLKtQWIZCXgWCVJYbZZceA28g9
        /6jhDtj/Xhvoe/YjW93uNbTzCNcxJBcSX19uGUsNOIBYQ8qOIpfgokvV8+b6A8V5OcNBPgU3sNmxC
        Hs91y4jLyJ83M/Q0aK2ccnuZ7u77tKi432MHpx7SLd09SifP++BydZOEX/GMnQ0Kiipeovgq0ReC8
        SzHce549w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWV2b-0002JT-Hv; Mon, 10 Dec 2018 23:32:45 +0000
Subject: Re: Official Linux system wrapper library?
To:     Carlos O'Donell <carlos@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
 <20181112023630.GA20359@kroah.com> <20181112090828.2573987d@lwn.net>
 <b3d765e1-69a0-d4f0-b04a-40c19df8111c@infradead.org>
 <20181210092706.1aa54432@lwn.net>
 <f3db1a75-e6f2-06a8-5264-a6807b7b4538@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3dd97da-c246-6271-e1b5-91a858836422@infradead.org>
Date:   Mon, 10 Dec 2018 15:32:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f3db1a75-e6f2-06a8-5264-a6807b7b4538@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 9:39 AM, Carlos O'Donell wrote:
> On 12/10/18 11:27 AM, Jonathan Corbet wrote:
>> On Sat, 8 Dec 2018 20:38:56 -0800
>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> On 11/12/18 8:08 AM, Jonathan Corbet wrote:
>>>> On Sun, 11 Nov 2018 18:36:30 -0800
>>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>   
>>>>> We should have a checklist.  That's a great idea.  Now to find someone
>>>>> to write it... :)  
>>>>
>>>> Do we think the LPC session might have the right people to create such a
>>>> thing?  If so, I can try to put together a coherent presentation of the
>>>> result.  
>>>
>>> Hi,
>>> Did anything ever happen with this syscall checklist suggestion?
>>
>> No, we really didn't have the right people around to do that,
>> unfortunately.  
> 
> We already have Documentation/process/adding-syscalls.rst.
> 
> The documentation there is quite thorough.
> 
> It lists things that people commonly forget e.g. email linux-api@vger.kernel.org.
> 
> Would it be acceptable to attempt to collate per-libc information
> into the adding-syscalls.rst under a new section called:
> 
> "Integration with libc"
> 

I think that updates to adding-syscalls.rst would be sufficient,
instead of having a new/separate syscalls-checklist file.

thanks,
-- 
~Randy
