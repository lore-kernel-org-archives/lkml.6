Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E92ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F4C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7W7bdpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F4C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeGWVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:34:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35447 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbeGWVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:34:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so1182301pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+3cEd3AwDBSMg7Hby78x+tUmSJdKpokLuyblo952VGQ=;
        b=b7W7bdpYREzyChbvqyi8bZrLxyUHT46ZczCkxtHIAIP6WZoRWzOJONv24Hr+zjPJ2+
         Bbe7jv5yuR5zHb3+cYbu+nhXXH8GB453jTG6PwEINgNaCmE0CRtoB06hJCZpoKneX0Mx
         OQu10dfTSj9OKcnvEoWD+6sWXSUX8mh4U0OxPnlomsvISKhE05mvwfwL70BO2xbLKgVE
         e6EMTb5GlD5sslSegev3SEZMn/b8qyt7cuboJ9GGAzBwH23BJoUG0FtBlLCYPuuqLk6Y
         q+zOBti1wa0vS9iyaVH3JTmii0pDe9rvWqAJl18jq6jjrsX6Qm2XfD8Al41g8G8ZYTBD
         RoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+3cEd3AwDBSMg7Hby78x+tUmSJdKpokLuyblo952VGQ=;
        b=l7Mu0HsXOp5xuZ6cv9aFfvr0WbPIeOGgtx8DkAnMmNu6xS6Sy8K3Owml+fm12H0Pzc
         wlvKV7T/E7K/Ru4qAGDE7ZskfQSNAjKflKypNXHsTGbPa3FGAyDymPmA2GhcifpfQnSj
         oHSJj2IdySEu16fAqpWUEWG0xoBEq7V0nEqbUqIlbLZUcGXVTcmZSd7/woBW7mqskZpp
         uOg/ICoteBkwB+92aNI4p14BEdEzwOytHtHDFO091TjhrIvq6q10FFHo4ZAskmJzmxvl
         JPl+NwdaBH7QYauHNHFuEJShwI4DGuFJQ6J1oPD4lx2FnzEkyAJozgq5VeR9eJXUSS32
         eJUQ==
X-Gm-Message-State: AOUpUlG1A4aA+ypu8QdF0ks0lgZl0zqsygsxBqPHGGilJQlAybzD6BPZ
        MeQUVvqdektMi0zPLhyFsOuNzg==
X-Google-Smtp-Source: AAOMgpe0iKj0SpCytzZN4LqtizkQo/aiO4kcoitIVGSHLbpPP39LRnVoAhcijhFjhswQMwvRwIjfHQ==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr13472736pgv.280.1532377870135;
        Mon, 23 Jul 2018 13:31:10 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b20-v6sm15701849pfc.178.2018.07.23.13.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:31:09 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:31:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, hughd@google.com,
        aaron.lu@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <3118b646-681e-a2aa-dc7b-71d4821fa50f@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1807231329080.105582@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1> <3118b646-681e-a2aa-dc7b-71d4821fa50f@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Yang Shi wrote:

> I agree to keep it for a while to let that security bug cool down, however, if
> there is no user anymore, it sounds pointless to still keep a dead knob.
> 

It's not a dead knob.  We use it, and for reasons other than 
CVE-2017-1000405.  To mitigate the cost of constantly compacting memory to 
allocate it after it has been freed due to memry pressure, we can either 
continue to disable it, allow it to be persistently available, or use a 
new value for use_zero_page to specify it should be persistently 
available.
