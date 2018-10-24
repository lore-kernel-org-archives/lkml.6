Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47AAECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959542082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959542082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJYDCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:02:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44934 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJYDB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:01:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so6024253otf.11;
        Wed, 24 Oct 2018 11:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liRm4dcJEDZQBELcxjabLJk/PI2hw4zEvCBAczF59a8=;
        b=WiCbGX9/WvOjMcWFH1LDjAClK8zsvtvM+bddoA5B+VfRuQC1EQJ/xrwcVKzcDXyyi9
         Q9U0vczM/eraZTNROgdI04PsyyLH7x2hpJOvFluhV5ETuB84okjDgspiCKuBTMQ1TxDL
         vVm/zaqcvIjuuS/ouKAmPWrT1lodVAprq11e5Mx8gxSzAxEoAAKuewgSRF7Q3fXS/75y
         +mBAbY+CNPkRq9/8KAlWI5NfKzulnEPybKN6ivhOiFuDry+oi8j+YBQztkjpL6OYCzYe
         M7LXxLxort/jNUwUGNDc1Z+2R1izJsnEBT+Kob+U/CDWTXLcMs3yt57wKnEAnwiHRDLP
         /1CQ==
X-Gm-Message-State: AGRZ1gLUOnnsNri5woj04cDFtCCr+ach6zLowt9SAVrJiO19pFOiTB1u
        VvpQpsl26xPmuJaFmUKdxw==
X-Google-Smtp-Source: AJdET5dMKOLrjBZquYhG72Bnl3oQWL7EK1JX3Jgz9QL0rqbvmCzpj8sJaiMlMKWqkjfmU0LlFgwvpA==
X-Received: by 2002:a9d:7a93:: with SMTP id l19mr2256566otn.173.1540405969493;
        Wed, 24 Oct 2018 11:32:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j27sm1953032ota.32.2018.10.24.11.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 11:32:48 -0700 (PDT)
Date:   Wed, 24 Oct 2018 13:32:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nickhu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mark.rutland@arm.com, deanbo422@gmail.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ebiederm@xmission.com, pombredanne@nexb.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        devicetree@vger.kernel.org, zong@andestech.com,
        alankao@andestech.com, green.hu@gmail.com
Subject: Re: [PATCH v3 4/4] nds32: Add document for NDS32 PMU.
Message-ID: <20181024183247.GA12203@bogus>
References: <cover.1540350887.git.nickhu@andestech.com>
 <bdfe23ce3ded5299d7b525fcb16c353c2be31924.1540350887.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfe23ce3ded5299d7b525fcb16c353c2be31924.1540350887.git.nickhu@andestech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:32:40AM +0800, Nickhu wrote:
> The document for how to add NDS32 PMU
> in devicetree.
> 
> Signed-off-by: Nickhu <nickhu@andestech.com>
> ---
>  Documentation/devicetree/bindings/nds32/pmu.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt

Can you move to bindings/perf/ with other similar h/w. With that,

Reviewed-by: Rob Herring <robh@kernel.org>
