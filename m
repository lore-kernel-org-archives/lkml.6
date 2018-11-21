Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B18D2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMdTlTN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B18D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeKUNxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:53:20 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43893 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeKUNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:53:19 -0500
Received: by mail-pl1-f174.google.com with SMTP id gn14so3323470plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TZ1ILf36vluQRmD7+XUbNoBKgZDQAlA/hXOW/yYPvow=;
        b=hMdTlTN02M98lXyk7Ucwpt/RH5xmd+8WA/v/Jt3jTrFs0BJiYCEs05ZeW0x2farKNt
         Fd9C1DnZz+vZWHT8b2wmBMRfg8WMCjq+fzFMcVic5v/O/wcZVCUgtKO2oj6vJ1pVZv4b
         e3LibR8BfHSjVFWDxJ7n/xJDXTUwmJYxoOf/hEXGhGb1ved2rUF+NbW+2f8Nq4xidHpp
         +NKBTXN8ASjBchCl414x99gAISGePaLhBcx+GMHRgDHF6A+RpM8UPAPbIYIAQ4KfMKt4
         NJk2UoPwTCnQWg1HgopWoPMwzRRThJCgbT0LV/bY5lLHdH+K4hwIkClzKK7Ik2MiOlmo
         57fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TZ1ILf36vluQRmD7+XUbNoBKgZDQAlA/hXOW/yYPvow=;
        b=bzO2kFNVCayJHJCMigVIvJ0kWNr28mRJqEwcBmjluc9PPMsKplg0s9kmh6RVNEkIn5
         4gKq2xrxRYPVHj4/fyyrzY1EOUsTWbl6Rla98D//FRv4B2RwzlMYJTBZaS+lAxnB6oty
         StQefNkIaiHUTbJFhvmf7ZbHpKkjeeltmZTHPJWe/zfpNIXMEaR9hhfEmbPS5c2I+wKV
         kpjZGyEFB+VD6liWdUTl/9gsFoAf56cqEYQN5I/Qohx9D9zf503pk5qr2m1G2t1c2BAv
         DYocYk5AAP4nvJ1R2lm2f54RmcjNe61N1+vgBulKP4PP53eyGSWN76TNi3HgOGHIqSmq
         ju/A==
X-Gm-Message-State: AGRZ1gJm6sAoku30A5DAgl4l1fS1aeNGVXwg5je0caNNSPAnFcZk6e10
        +2hCpDc0ff/dJYAGxABaUMBcww==
X-Google-Smtp-Source: AJdET5c+OxqqMj0UgKkzjCN0oOuM0t3Gsc4pzY5/JEuvn0VxEf1n4XATouVx0bruhL0HTnGnRsNMeQ==
X-Received: by 2002:a62:3a04:: with SMTP id h4mr4950852pfa.119.1542770448949;
        Tue, 20 Nov 2018 19:20:48 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 18sm43687573pgl.50.2018.11.20.19.20.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 19:20:48 -0800 (PST)
Date:   Tue, 20 Nov 2018 19:20:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
In-Reply-To: <alpine.LSU.2.11.1811201630360.2061@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1811201852370.2804@eggly.anvils>
References: <20181115143204.GV23831@dhcp22.suse.cz> <20181116012433.GU2653@MiWiFi-R3L-srv> <20181116091409.GD14706@dhcp22.suse.cz> <20181119105202.GE18471@MiWiFi-R3L-srv> <20181119124033.GJ22247@dhcp22.suse.cz> <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz> <20181119173312.GV22247@dhcp22.suse.cz> <alpine.LSU.2.11.1811191215290.15640@eggly.anvils> <20181119205907.GW22247@dhcp22.suse.cz> <20181120015644.GA5727@MiWiFi-R3L-srv> <alpine.LSU.2.11.1811192127130.2848@eggly.anvils>
 <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz> <alpine.LSU.2.11.1811201630360.2061@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Hugh Dickins wrote:
> On Tue, 20 Nov 2018, Vlastimil Babka wrote:
> > >  
> > >  	finish_wait(q, wait);
> > 
> > ... the code continues by:
> > 
> >         if (thrashing) {
> >                 if (!PageSwapBacked(page))
> > 
> > So maybe we should not set 'thrashing' true when lock < 0?
> 
> Very good catch, thank you Vlastimil: as you might have guessed, the
> patch from a pre-PSI kernel applied cleanly, and I just hadn't reviewed
> the surrounding context properly before sending out.
> 
> I cannot say immediately what the right answer is, I'll have to do some
> research first: maybe not enter the block that sets thrashing true when
> lock < 0, as you suggest, or maybe force lock < 0 to 0 and put_page()
> afterwards, or... 

... I still won't adjust the patch tonight, but the answer is obvious
now I look closer: as you show in your extract above, the only thing
it does with "page" at the end is to ask if it was SwapBacked, so we
just need to set one more bool at the beginning to check at the end
(or I could make "thrashing" a -1, 0, 1 int like "lock": but my guess
is that that would not be to other people's taste: acceptable for the
arg, but stretching your patience for the local variable).

By the way, I do have a further patch to wait_on_page_bit_common(),
which I could send at the same time, if it sounds right to you
(but it's a no-op in the put_and_wait page migration case).  That
__add_wait_queue_entry_tail() is right for the first time into
the loop, but I maintain that it should use __add_wait_queue()
for fairness thereafter, to avoid repeatedly sending older waiters
back to the back of the queue.  I don't have hard numbers for it,
but it's one of several patches, each of which helped to reduce our
wait_on_page_bit lockups in some (perhaps unrealistic) stress tests.

Hugh
