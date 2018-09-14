Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05925206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDs05Oqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05925206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeINS5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:57:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37397 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:57:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so7561188ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXbLJz+rBvXr9FKwjGaEpyNwb7oyv/KvfhC/JCLkzfE=;
        b=GDs05OqeQd+cCSE+LlG3QrLj4C9lIdBQTH5m+il7Lilr1Ms/SAGGI7FX+Qxx0X4QD0
         A8EAhy8R0UjqQkoCiMcX2nJVoyoVDG1KudGBTXzmH4TbOVex6Z75wttkiKyUjEkcFCH+
         yA/jOqOuzDR1/a6EOKEA5haU85FoguhlOTr5PIrkknOKk/yxqiJSOo+Lmg/biz1FRCd1
         w3Te9t+8DGblMQgfXZCmH24CRKMsI6QTwGUG1dkZKxLlpUheVL8ZGwSwPhEWaWXJg5oG
         JonTW1K188hsUKAIAXnfpR7aECox5vwpL9CknGD55ZP441F+KUik1aggiMwKYvf6iTZf
         5pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXbLJz+rBvXr9FKwjGaEpyNwb7oyv/KvfhC/JCLkzfE=;
        b=Dgr9H2GpEv+N//8ZJStYutmPr334SpvDJrIOIB5w+NGdf5klK0OWSr0tVtrkJPS/Tv
         5xF7rPt1GAQMj/ChbNIAEv60EvAujkcWHqHWMM8liUHutnAR2HyFKBrzC/PKTF6rMC+2
         GKYgfwt4NBnS4uZComW7tqK5PK+ZxbexAofmdQsCpMbSNYHK7MSu8DyPZwZ25byDDAkE
         STtwlzdGewURMQgg0Vgfiqmc6Fwbuw83Aml7R3mhA/L8xJpG5hkYFbmQgiiJgilXWgEJ
         Zzjh+0/NENQYtKZDxOtFl0DCgeMk99HFbDeDATtfr73BOmDdzapq0tInx2uFpbmCIgJq
         1n6w==
X-Gm-Message-State: APzg51A0yNM1gDFeYFAYJoMgEUmIPKnfEiJv0L0GxSFlRE5a0hkBPvjn
        /abumKZ7RSxjHi99SeeH9Qk=
X-Google-Smtp-Source: ANB0Vdansp7JB1qz0z6PlTgit9YDrloJbs2cBPNH0B/SxhRfoklmDSr9LUD2L3jr6gWzymft26Z51Q==
X-Received: by 2002:a2e:1bd7:: with SMTP id c84-v6mr7997183ljf.0.1536932575915;
        Fri, 14 Sep 2018 06:42:55 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m18-v6sm1229576lfj.39.2018.09.14.06.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:42:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oN7-0002gz-JL; Fri, 14 Sep 2018 15:42:57 +0200
Date:   Fri, 14 Sep 2018 15:42:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/50] f81232: switch to ->get_serial()
Message-ID: <20180914134257.GH1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-20-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-20-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:19AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
