Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18B2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0AeN/ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B18B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeJMPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:34:20 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44173 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:34:19 -0400
Received: by mail-wr1-f48.google.com with SMTP id 63-v6so15676705wra.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3Xd/5wuKgI2DRsM/Jcnz2vQKrmHbWr52nZ78toJ8ltE=;
        b=d0AeN/ju+TvyD32S29JKTawcwo12kzxCh78r/G4wLaG5D5hA11PnP6oRT6c9O1p8uq
         7X9LI5v/jkqjw4a62h/dMky39JpD+mBj8BqjbiD98K5m4LqLJJuFkPicCh99pIRPNBrO
         QqisBVqtQX5cc/dd1quvAoEUS9Za+GbaDSmMB6X0wdw+71soarv68DFUT5XIh9SLXfDS
         7AZvDKP/HCm2nv+Zscy8zy3ovSu/USDmMzQVd6W0mSiG86iqrUT1r+EzsdA+t0cMdWTg
         qakuIfKkkanTcJHCJ5AHn71UhhMNBRWmpWymlS6/acYlFI/XuebsNK9/HSkcIymbN2k9
         OHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3Xd/5wuKgI2DRsM/Jcnz2vQKrmHbWr52nZ78toJ8ltE=;
        b=Hmx0Chm/7Dl5tqNkdbd6DyW+lWZxpmqe0ZQDiOm1rZA70vZnMHmO6Rm0osKnAnZsHF
         PjZUUIOZClwZdXCG/0wvcRqqOgTK1if0m7EkfAgGwcrn7sYUNYwe9LS4ngpApRqT6FVd
         HY7vkVZm5uDt5CF5HYauAPBOizVOpJzVlj5bSiyxgOLLF4LGDmmBsngmSSS4m/M4RFyR
         aKD7nPQSBjssTu61hyBzfR0EXf9j21nWhjlwJeQfv7W+dPs/TQtewjLVaf6JPcrZU594
         0GbRkoyyBAEH1xBHnSoCq0R2ZL9AXH69nVHKR7Lc/YImQI2WRqYGoTan7nzCIiadnd4R
         YNYw==
X-Gm-Message-State: ABuFfogyAV768WIrRUJYFJJDBG29Cuwv6k9/nnebdVRDaAyT9uohCfth
        CyUTVbX8ygJkN45yR/ITboKifz0=
X-Google-Smtp-Source: ACcGV63kAxqx+3xdw1Izf/TBSLzuF2pW12G6w5CJPn5BcE0OGI5Vyuk4Xm7fNo8jTokKpwbgkyFKZQ==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr8001070wru.326.1539417489483;
        Sat, 13 Oct 2018 00:58:09 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id g3-v6sm1933158wrw.81.2018.10.13.00.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 00:58:08 -0700 (PDT)
Date:   Sat, 13 Oct 2018 10:58:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: proc: Add fs_context support to procfs
Message-ID: <20181013075807.GB25825@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct proc_fs_context {
> +	struct pid_namespace	*pid_ns;
> +	unsigned long		mask;

mask should "unsigned" as there aren't lot of flags.
