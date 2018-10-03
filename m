Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C18B20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99jRDws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeJCMbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:31:38 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:40563 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:31:38 -0400
Received: by mail-pl1-f169.google.com with SMTP id 1-v6so2878227plv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vg7SRoj7yAJ2vTnwB8FUNMQs7vEPUrfNYQlTrmGRmw4=;
        b=l99jRDwsP8sCeqQ+NMUg4SWvQPNxLBzJov/0NT38yGnuwGNiI1E3WqEH0LvvP4sSTO
         pUWG7pdGpLvtZKMBSzAK7VAiHipviusz0FpC34Kr0zwNlYZAqAAf+xO8az9RbQYKBL7n
         hAKeIth+cZlVJihKMubHnKEVWnhNWdirXkqUKCOWnp3bMJi4xSAQzHMbOCzBDPeo+cB3
         Gmaw9DlHstfLGk0oILZSX7W2W3wStllG+Mc8kVf2ORq7Gs2g3695T7nvcNhYjIkvtxxO
         kv9p1gKpBkaB62SYUcJx7NYurQRjwk6Zyog8dZhY3B8eL7tI7I75oaLo35HrNNzBZ1NK
         mI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vg7SRoj7yAJ2vTnwB8FUNMQs7vEPUrfNYQlTrmGRmw4=;
        b=icc+P5yfcNAcxeYEcQtUj1ZQl9QzRH9mXHLw0206+17cEJMa4Yd0q/nsbeolUKA7Ni
         bSk1gD4lBZXGjbxNYdNREerphtN/0Ywhh9OFAaONnA8irR17bxcO6uFbnnVhE/BQHpWV
         Du9SV/maIoFqGBNZQqS+xc/bF77uNEK1L7TN08hmkWS9jbhwmQYaDRWkBduDMVxwKphC
         WjCMP2Q+onRosY7gQJBBe9Y5zPIwdr+wjcLnhTYxYBD/Xi1cPxIF8++kZH/635MFpr/q
         xD/DbSGRqEOdo70pvmtr9N7Vyh5ga2tDvRmZyvnsfc/aakMJSytUg3k9THZM6D3z0kwE
         1stw==
X-Gm-Message-State: ABuFfoiXkq86h+kBXfu8OCu7I3j+2szV8rCv57AxqGDZNl848fTp9tZO
        kWzNplb26SIVINkVyOvDHPM=
X-Google-Smtp-Source: ACcGV63+eL+VExziZd2iNuKdeuPPcAeG1JdhUv62hrGrtsz8H8P/j6Qp24FzpQB9uzzmGaC2pXOXUA==
X-Received: by 2002:a17:902:7283:: with SMTP id d3-v6mr19734670pll.326.1538545488370;
        Tue, 02 Oct 2018 22:44:48 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id s78-v6sm1300508pfd.138.2018.10.02.22.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:44:47 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:44:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 7/7] powerpc/64: Modify CURRENT_THREAD_INFO()
Message-ID: <20181003154442.5d77ad9c@roar.ozlabs.ibm.com>
In-Reply-To: <e218eef4c27f7cf00c41914ba977b29edba943ff.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <e218eef4c27f7cf00c41914ba977b29edba943ff.1538396659.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:30:31 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> CURRENT_THREAD_INFO() now uses the PACA to retrieve 'current' pointer,
> it doesn't use 'sp' anymore.

Can you remove this too now? I think it will be clearer what's going on
and easier to read once everyone remembers current is the same offset as
current thread_info.

Overall nice series, thanks for doing this.

Thanks,
Nick
