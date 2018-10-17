Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ABFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC002098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ6e9koz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC002098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeJRDWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:22:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:22:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so30966201wrt.10;
        Wed, 17 Oct 2018 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hLtFXLB8dtoWLMgX17Lw7RFrAef3A56DkN6PK923kM=;
        b=iQ6e9kozJbDi39gRWY7ZbEWTR4+frzQ9csaiGpQW4Rtd9rEuwsjJbz8ybQdRTGt2DQ
         Us9eXTIOcPTTiJUar24ghBYkUraihL2ozUW91ZsA8j1odDxq7/EI2BGfZAQPD4xwmMVk
         XIXL19x7/fG5vkJTlFTfxEq2KyG4s0wsYM1oIP1glvZih8J7ulnYcFCWjsOLfZ4917DH
         0nt3CkOtvkO8gT62GzO5blOZhxvBBXZAKscu9OIHlDjhYPVXKWe58Ke9Mm+H45VwhJsD
         qlfZLt3HS9wSH44UGe/WpVWASTocXaW+/xlRC6dRzCCmIHZ/bjPl7CfYWPOAj2IeqI7G
         cGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hLtFXLB8dtoWLMgX17Lw7RFrAef3A56DkN6PK923kM=;
        b=Slb+YIpxP02ZTggzSntJjWdHB13zF9n45pmmUgCOtV7uCQZheVmN6PD/+dam2mw2Sm
         +uI/VgdVXvIw34NxPStIhr9QHiN9qELAc3xH5l8+zQil5G89JTHp14Ts3HOyRT9k8pxE
         nWs90Wvl66K7MHUDfhVN+Gsto85jGxsH8+4ZoD20sAwuTesHg9i7GCl3vMK4HdRUVa/X
         QO6ZbboU9i/W6F9dTZtZGfenurP5MDlvcAJkuresqw2a+1BYraOEIOgBwfpw1+BVtz1a
         +/ieNXNMAUtQDtaHNuo3Ang1SIg9NWUURa4/sXPBo6ZxiQIeMsieauylrwTeGoDZPZnn
         DICg==
X-Gm-Message-State: ABuFfoglmsJoImRp5T+fKY0XB1GsfGymUo+8mf1HUVGV1ObR4BbIj8on
        E6o7G7lVcg8RTXMKMAe44Ao=
X-Google-Smtp-Source: ACcGV62ynSp2KYSTSh7/Qml/as9Ou2DIwx00kDqHbq8RO9GZbzVgyy6bETZ5R/Jzz3TSNGUTqDZ1NA==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr25238062wrx.271.1539804304177;
        Wed, 17 Oct 2018 12:25:04 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4027:2900:d1ab:893d:541f:d1a4])
        by smtp.gmail.com with ESMTPSA id y125-v6sm3568025wme.12.2018.10.17.12.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:25:03 -0700 (PDT)
Date:   Wed, 17 Oct 2018 21:25:02 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 1/3] kbuild: Add -Wshadow to sparse
Message-ID: <20181017192501.3yqfq77q2n4xdq7l@ltop.local>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
 <20181017170554.18841-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017170554.18841-2-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:05:52PM +0200, Sebastian Andrzej Siewior wrote:
> I remember that `sparse' used to warn about shadowed variables but it
> seems not to do it by default anymore. It was useful.
> 
> Enable `-Wshadow' while invoking sparse.

Hi,

I made a quick test and I saw it would add a lot of noise because of
(valid) warnings coming from macros using a statement expression
redeclaring variables like '__u', 'tmp', ...

BTW, as far as I can see, sparse never had it enabled by default.

Kind regards,
-- Luc Van Oostenryck
