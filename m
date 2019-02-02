Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D7C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BB12084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRju4zgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfBBA7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:59:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32878 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfBBA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:59:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so4080381plo.0;
        Fri, 01 Feb 2019 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HMW/FMkhqaB4zEYchULm6MpORv5yMKsYsiw2e9nQxZA=;
        b=eRju4zgM9xFXZyfOwiLeuoAGZx+DaB08Xje1nxEDUvTWOXoqtVrswEabbpDH8WkI+j
         WAK2wH43J0T0698kLjnrDIMckEqQ75gdhd2JMBRyFbLN+blE8UiDNuHYq/bTZosWlBNH
         mOVYKSmzcoJRug7V6F9EHXAQL/Sl6ijx88T68T/n7TivJQL2Hd61C+cy7RxgLmWK0BHJ
         Z3qlVXDoWFceYtWU89T2T16z3BiRW8wtCFGqo9Ov1JakAl5KeqHpQHXAsdLP/RYYP8oz
         pcIEMfckcd83Z5kF6PfDhig9iseafg22oSbiwNccfF5z/PQTOVHuWlWY+FO2U/EBcnwB
         vdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HMW/FMkhqaB4zEYchULm6MpORv5yMKsYsiw2e9nQxZA=;
        b=DbIDnVQ9u6K6+OXGikzAmPJ1TP0oY22mIOm5hdJdtA++AXMBxskXNm3IbaUL5eDG1P
         /poo4gKv7+x1W/MecIu9UDvQ3zcSqKh4+hzsNs6wqoyV4H8DsYDFo51OYjPBvc/tDt6N
         q+n0PLJND2gecLM57li6pk4Cxl1193yuEX15HMCu557VbHgatUMS4QoPBhHsDtbVIK25
         61etNpSG10dkhwsll1xltGkahmLYvqKmAV4ZReVsCMmrBWaCrg3ZdpZeomssXF0qOWB9
         y7zPfYYF/nRrMhsDTW1TSs1EMA9fVKQwTXcyMrfLm9A8nP03Zid6f9Qytp4Rt0AVRHgq
         lQQA==
X-Gm-Message-State: AJcUukcnSv3GIcJ4rPMPI9E0lRGrBHJxfgQnEjqKoKnOXbasMwzcn/rb
        P3J+gfO0H56wYHfDWPo/1Yc=
X-Google-Smtp-Source: ALg8bN7otX5werawFMy+3MlBIphh87r2CkXXWRYvktP8EwiieKjqBuYmkHq+dOy0dcEiNrAFZ+Dl5Q==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr42177714plh.78.1549069172103;
        Fri, 01 Feb 2019 16:59:32 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id l82sm8592561pfg.127.2019.02.01.16.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:59:31 -0800 (PST)
Date:   Sat, 2 Feb 2019 11:59:28 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 4/4] powerpc/livepatch: return -ERRNO values in
 save_stack_trace_tsk_reliable()
Message-ID: <20190202005928.GM26056@350D>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-5-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155724.27557-5-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:57:24AM -0500, Joe Lawrence wrote:
> To match its x86 counterpart, save_stack_trace_tsk_reliable() should
> return -EINVAL in cases that it is currently returning 1.  No caller is
> currently differentiating non-zero error codes, but let's keep the
> arch-specific implementations consistent.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Seems straight forward

Acked-by: Balbir Singh <bsingharora@gmail.com>
