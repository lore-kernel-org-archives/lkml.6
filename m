Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5BF20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Nfl2Ttzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5BF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeLCJ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:26:19 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34303 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeLCJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:26:18 -0500
Received: by mail-lj1-f179.google.com with SMTP id u6-v6so10667886ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbSMCb1Mq2H4sxyH1MJGd/I/+g27a+JSl8qZOLJK5AY=;
        b=Nfl2Ttzt45q4y5RnIN/qdviAg15/BFzmXvP5ZhC4F0S/EeWH9x50TfoNwitfnoh5oj
         v6oCR8payANrHYgtCazMuQSYP9LYOdIB7UFY/Xl00B3wRrg/cJgEx4yKE3/zWxv3LkpG
         Hkmgpu8oRBdvojO58TzoFTt4lpibOXACkkNvkpJZjfNIhxZtwtI63+nMSyqV4hWAwffm
         Xks/Rb7A6YSxY5DeMQxBL0EUT2B3aybo0mg0uvBH6eHGlzBjLa4qNQDp9orBNrLJydp8
         HIviuV8KX6uxcwRbCDiiOcFvCMIj0RNx3s2VJhrcdRZLF1aEiZnG0SLi+0jNbGjCwC34
         /mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbSMCb1Mq2H4sxyH1MJGd/I/+g27a+JSl8qZOLJK5AY=;
        b=nxllUy+lpK4OPLH8JTGyAkYYVntuWu5H/QEo/NXsPa7lktXwF0SzfmbYhjjICfhO7z
         htflqFLW56rN+qdAplqX6xlNB8PPpRzjjG6vikam5MKdy+fCyBWuFGDzqv4M0t9UHghY
         Ze5HET5SW79tPD/FaQLhV7yVvAlORT92ISM6PDfAPJNTmBl1jHwXJd8vNLvtPTuAHdej
         b2rjBmocIIUk+EtVCmDLOJqcFD1CdUlbRRNU49JSoZNLujUsSENmM4Q30f1fHn772K17
         PZOmwurCfKlXjbhP2IAYLcSSvc9RGO4UcWz4/mMaQn4fQH/1nVuIZjBVXzwlb8ysyOcN
         xRVw==
X-Gm-Message-State: AA+aEWaeYe2Ufa35uo3dnR4JTc8PN4pQsC+cqewzLmq+gQKDAFxkc2UZ
        j7AWlo/rGqe2f2YHe0zPBpeVzw==
X-Google-Smtp-Source: AFSGD/U8GRq/4iOJkwo2L1l9zTy0ezRzhZBp3QgXsyPifV0QYZB4MdnjVGZtdYEvYK0W2kPbsxKSLg==
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr8006133ljj.149.1543829163311;
        Mon, 03 Dec 2018 01:26:03 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-162-212-127-178.mogilev.dynamic.pppoe.byfly.by. [178.127.212.162])
        by smtp.gmail.com with ESMTPSA id n8-v6sm2572112lji.90.2018.12.03.01.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:26:02 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A96463003F7; Mon,  3 Dec 2018 12:26:01 +0300 (+03)
Date:   Mon, 3 Dec 2018 12:26:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181203092601.h7fuhvbmgdbfgqcd@kshutemo-mobl1>
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com>
 <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
 <20181110122905.GA2653@MiWiFi-R3L-srv>
 <20181123155831.ewkrq4r27rne75mz@kshutemo-mobl1>
 <20181203030100.GA22521@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203030100.GA22521@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:01:00AM +0800, Baoquan He wrote:
> It looks do-able, not sure if the test case is complicated or not, if
> not hard, I can have a try. And I have some internal bugs, can focus on
> this later. I saw you posted another patchset to fix xen issue, it may
> not be needed any more if we take this way?

Well, it depends on what is the first in the KALSR group. The fix will not
be needed if direct mapping comes the first.

But I would rather go with the patch anyway. The hypervisor hole is part
of ABI and we should not calculate it based on other movable entity
(direct mapping, LDT remap, whatever). It's too fragile.

-- 
 Kirill A. Shutemov
