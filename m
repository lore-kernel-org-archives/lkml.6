Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B90C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106FB24C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="WDK+HdfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106FB24C8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeGCIMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:12:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39424 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbeGCIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:12:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so607677pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoJfZE856ldxfVFGysRD97W0EZBirPjDWRnCchmOeCU=;
        b=WDK+HdfFFoIP3WwSj8+GfMTviuiUf4zPVs4mgrgJiz5+LSkmsCIDOKOTpaHtL+1mPj
         VHqONe9qtgcAk7frJbJhLWG+cszOLegSQX3Gs7qKraWb2B0HyoVNDsajBGUNqePEBTNa
         EKMydcvCQScQjWWHVZezlNoDtZg+yHjLDDN8DsOetj2pwu3gw20dq+23imOEfTRQFq2z
         QoAeoMnGvC+rzVMID8tFYwZF1HcFgOlYnNbAUm0K5UNRoM6kTT3VTw2X8e88+GGL2r3q
         aJGxZM3qAnS+OBOsgDkJZIQUA1sHPJkAWE1CSeacT4H6Fwng2GdFEQI27SbMKYhG8CPR
         tEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoJfZE856ldxfVFGysRD97W0EZBirPjDWRnCchmOeCU=;
        b=aDSa2BHkxzM3Wjzefi63wsFhkbheVXHdE3RWgpKEdCPNaBvEGaTPTJ8ma8EDebAeLp
         tKWxECJ1tBAtCPLvTE+wK/w/KMia/PMMOZ0ScOQj8BB13qfbb/YLuTlvcaha6neKWnoo
         94iU0wtr0cwgIGo/LlXdJ8q97hLFtCtAF3pjR88/HbpXZQ7Q2TnfJA3dTBa+msDmOrwe
         1RVrN6HIPWO+EBYavYOAf8UtRHNSnb6DgKK6BUn2c1HdTn/D/4eD8hPot8c/QZTWRdCb
         R1gt5GqtKJS3KRJSfana1BHJKyN2S6NMyUTCmz27IEBsNGNUuVlnLNK9Yi0VxfrIVUEn
         Secg==
X-Gm-Message-State: APt69E2wSZZ+BN8WX7P76c6YLhVLERCpBqJ6euSSTWs0rnD6I4f+B2eA
        Tq7EuEHqD8JgUzD3XhZCM5zzaw==
X-Google-Smtp-Source: ADUXVKI2Rmu9QFAFbyi46oRTP7wkBNcvu2vMloDNmhklF4m6mw94nYSn9lxHssrhrKyG64JYMPYUuA==
X-Received: by 2002:a65:602c:: with SMTP id p12-v6mr24502297pgu.209.1530605530133;
        Tue, 03 Jul 2018 01:12:10 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id 133-v6sm1388399pfu.158.2018.07.03.01.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:12:09 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 87E9230003C; Tue,  3 Jul 2018 11:12:05 +0300 (+03)
Date:   Tue, 3 Jul 2018 11:12:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180703081205.3ue5722pb3ko4g2w@kshutemo-mobl1>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180702123350.dktmzlmztulmtrae@kshutemo-mobl1>
 <20180702124928.GQ19043@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702124928.GQ19043@dhcp22.suse.cz>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:49:28PM +0200, Michal Hocko wrote:
> On Mon 02-07-18 15:33:50, Kirill A. Shutemov wrote:
> [...]
> > I probably miss the explanation somewhere, but what's wrong with allowing
> > other thread to re-populate the VMA?
> 
> We have discussed that earlier and it boils down to how is racy access
> to munmap supposed to behave. Right now we have either the original
> content or SEGV. If we allow to simply madvise_dontneed before real
> unmap we could get a new page as well. There might be (quite broken I
> would say) user space code that would simply corrupt data silently that
> way.

Okay, so we add a lot of complexity to accommodate broken userspace that
may or may not exist. Is it right? :)

-- 
 Kirill A. Shutemov
