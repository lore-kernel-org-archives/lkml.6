Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97DAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92C921738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY70vPFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLYJs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:48:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37517 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeLYJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:48:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so6419490plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEnB43lmYEuotLppbENSEypUTLE7QHY789XEJ6SQQcQ=;
        b=UY70vPFcWh+nt2y5z9cAOCH7MEc2v09fbKY1c6QjxZXBqFJ5d1EITM07pkumRVw4KS
         fER0HLvPu28okV3EIt+PGRAZlCZBaxJBiZRpBai3R6BHu+F63L500BW7117n9hDbTt9d
         NMaIxkmWdncyZSZlE9RwgKDncYMVaNXTWqUy1jKQv5mauVGEcYaWHYc2HvuYAuBsrwXe
         C9TLl527mf7mDK6pVPhyP6Id3qXH3X7g3WW23+ISdNUPGC2G4zb6kmW7q3bBYIHWvwRY
         4LLUVKzgB2yHgKvCjwkW9qQ49L2efZGimf49xoE+GaNJgOVTZ4J8cj6w3Fd19xt522i/
         /pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEnB43lmYEuotLppbENSEypUTLE7QHY789XEJ6SQQcQ=;
        b=Yq/qSOm90JFrFNVCKRMPRuMOtnASRdE4oVwXGz7t1SuagjocN2hK3iPZGd3v5b7ZmK
         etQRgmv9DiC7BJylVoQR4yRR53ZnXJ/QeS5OuyZHP/nLV6OAYKgE45bylCHW+cs+TvFR
         V+l+Gme8PEz3R4I2HEL6Ay9M/poibF5vLDw9aXo3fczA0q0l8iCJrsnd+2xcJ3UnCTod
         IWK9MR2pq7MSetFqZQMXtTO90m4DTOPu112aH04pXhLq5VdHxphkz344CRPl61B+L55r
         qWcm9a2emEMJy/J+g9L9qaGGHt9b7HieNYDWzdLT+G2RViz7MWvvc5CL1VoVMRm3F44r
         F2yg==
X-Gm-Message-State: AJcUukdnW9ntEimOYWmoTyXJqiE1FQNF5j/jbH4JJmLDSB6h7CX3PzjQ
        FmyUIRwK+7yCe7Lmz495T3E=
X-Google-Smtp-Source: ALg8bN6VMU8E2rF3NH9gT/DcLnJfszwNU572FhIQnzgLX8dMSoMfaZuPw+YmYT7l2n6GEdCP1mjeNQ==
X-Received: by 2002:a17:902:5a86:: with SMTP id r6mr15212596pli.301.1545731336109;
        Tue, 25 Dec 2018 01:48:56 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id m65sm56714148pfg.180.2018.12.25.01.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 01:48:55 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Dec 2018 18:48:53 +0900
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/3] fat: Added functions to determine the FAT variant
 (12/16/32bit)
Message-ID: <20181225094853.GA526@tigerII.localdomain>
References: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
 <874lb3jflv.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lb3jflv.fsf@mail.parknet.co.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/24/18 21:04), OGAWA Hirofumi wrote:
> FWIW,
> 
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> for all of this patchset.

Looks good to me.

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
