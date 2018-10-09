Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D429C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F12086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5N8ktcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317F12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJIQke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:40:34 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35254 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJIQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:40:34 -0400
Received: by mail-wr1-f47.google.com with SMTP id w5-v6so1005409wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HEd9kIeDBSMqBue47ntaABXJe7A++WUMs1Hq2H2H5Q=;
        b=Z5N8ktcQPT5VWvZ7KQMoExqkJ4NkwPaS3LknMQarbsouqtNIu75oOyS73mmPZXc7l1
         klng2Z6wGyQ2gQFQH3AGKHCxI1CVz07w8d9qDfr941hywEUBViASffKzm1y7TasJvAaV
         O9c/ymQZSIrkOKYag4aEc9S45zLLD0F6g7SrPiA66GQh2zn2Q5Lt7/UFPj8bQTkutidC
         VK3L5HohikstQ9RdzrLNvsxzJQAM+VzrPHNQMvI/QCpIq7AA+mC7xHopW9ZwDHwtkTTW
         s4qQ57o4KvT9b3PHIWUUbZYcI8Gqh4EH8IbzB14QgjDeYGuY01i3tyd9iF3YoWzKo1+4
         GCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HEd9kIeDBSMqBue47ntaABXJe7A++WUMs1Hq2H2H5Q=;
        b=DnWA5kfWk147+UoKEiefSrRE0aC/1TQUQyJoFiFTWS7zGZrX5u+mP9bBToKH5ByRf9
         9Ugc+uGteN3Jbj3RM/z4SnJ3fybpCwvwVfd2jSIEpbSn/Al4dtlHCIBd+T7W3ZzrQoxA
         9b6JYRoc9S1uAcg8ConhHLvX4wVjkUhOOQpW9Uvww7t9G/JbIogkEqs4mktVTJcJ67VY
         IbtkLkQOdmJ8XvdbWjs2ufhA1ZWDtBx9uJA+vgOGMLNRwmi7S20H+C2CISKiROGYkV9d
         tRRWgchDBEaVSi+qcTNWeZipETdibDYLlbMyQKQ7i6+5+eSEVc9WQEd6C97UBAltREku
         I8Kg==
X-Gm-Message-State: ABuFfoj+3Zn9HuMZ3/Ed0x9Rcv5BSY/7Yrbys1cZms5WQVriVHFVYo8r
        RJ2YoAWL6XgyiNdZz6g/3x4=
X-Google-Smtp-Source: ACcGV635MVOOlfdxtAnSBUgEMFmsp+Ys24NisP5i42qo0KNyMoAzsRXV0WsXBtSa+1dewE0uXLARog==
X-Received: by 2002:a5d:6383:: with SMTP id p3-v6mr19636080wru.291.1539077074512;
        Tue, 09 Oct 2018 02:24:34 -0700 (PDT)
Received: from gmail.com (net-31-156-131-143.cust.vodafonedsl.it. [31.156.131.143])
        by smtp.gmail.com with ESMTPSA id u191-v6sm14515174wmd.31.2018.10.09.02.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 02:24:33 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:24:32 +0200
From:   Paolo Pisati <p.pisati@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     Paolo Pisati <p.pisati@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 4.19-rcX: WARN_ON() arch/arm64/kernel/setup.c:271
 reserve_memblock_reserved_regions
Message-ID: <20181009092432.GA10312@harukaze>
References: <20181008151138.GA19635@harukaze>
 <47fa0375-ed69-0cbc-9dcb-0cafb9184f24@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fa0375-ed69-0cbc-9dcb-0cafb9184f24@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:03:27PM +0100, James Morse wrote:

> But! DT's that have this reserved-but-not-memory are already out there, so we
> should work around this in the kernel.

Ack, thanks for the explanation.
-- 
bye,
p.
