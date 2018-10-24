Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B5ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E85920824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlNY1PEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E85920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJYC0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:26:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43516 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYC0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:26:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so1947602pgv.10;
        Wed, 24 Oct 2018 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LGk9bE7K2txnEnBmkjxygmyAs1P9CBD0ffqqsyUXck=;
        b=qlNY1PEs7HBCUWHKnd8egg53SZwG3qAhMGmfd+TL6bMOLD13qrs4z7NJ4q81mlIwSq
         9zTQYbSwi4YtuKRRP6bQtokyXnW+SGNxWVMp/jix70O6FHg2g4LRD2oWiXN4EDLozSWt
         oODWJiS1Og35djCjyVXy8TleLVXK8kg4NjGBe9R44aE/efbh75jKn0s5JLrVHevY5aNF
         69QK1KAkROH+AqlkXn0szDu5XaSJLVEmicMhXPYEEMxMUAXmL39pGDKftz3NTt7MQ6TK
         mMcKjVaDxyAPySru3+a8L4HH3dsPz8os5kcRQQUHvj0q0fMw0s/2CdQ6O9thGaGyuyl0
         DfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LGk9bE7K2txnEnBmkjxygmyAs1P9CBD0ffqqsyUXck=;
        b=ty3xlfAovG1vGcTMSjx4h0E+Hj3vSTmCWCJ6gMb4c2relASar6nL3Q60RZ3ZgoT7xw
         Rsv6Y78OM4ql7gyKYpkBpeMCC1BEZ5Xi4y+OyZqWL6+nd0dQlPCJrWp1PeExNa8o83m1
         89x35CHr7Lo04xewJn6rrlILUo2BDD9rlsnZbNC2nhSRVHHH8C6Z7wBWXbQLaNxD0Zng
         zQYiPsEwRVzqZ5jKjwbveTxKaBsghLMRw3LNJ1de65wn0BScn6aVMAWJ9Ol7FKkomF+l
         41682ICPKfp31Qdpz4krD7MSkXuFc2G+RPykbR7YANxk9ki2RicB7u+zj3A5B9hLkpa5
         9+Sg==
X-Gm-Message-State: AGRZ1gLkV4HfUgl4XIp8C6jrwfkpAOGEZ9Xj+ittpM3eUrc/Y2DQj6z3
        CA4NzNnVWWbLKE2ST66c9Mk=
X-Google-Smtp-Source: AJdET5c0s7eU3B+t/8hD0G4AO/nx9MdTfTyMshaD/BwICt5JeX1MGPTQDPtcT8NTCg4t6Quen23Drg==
X-Received: by 2002:a63:4d09:: with SMTP id a9-v6mr3452470pgb.408.1540403824755;
        Wed, 24 Oct 2018 10:57:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r81-v6sm19724380pfa.110.2018.10.24.10.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:57:04 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:57:02 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: (ina3221) Add PM runtime support
Message-ID: <20181024175701.GB6374@Asurada-Nvidia.nvidia.com>
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
 <20181024023623.4231-6-nicoleotsuka@gmail.com>
 <20181024092418.Horde.x5q-8wat9jjHp8dU00-w2gW@cp2.active-venture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024092418.Horde.x5q-8wat9jjHp8dU00-w2gW@cp2.active-venture.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:24:18AM +0000, linux@roeck-us.net wrote:
> > +fail:
> > +	if (enable) {
> > +		dev_err(dev, "Reverting channel%d enabling: %d\n",
> > +			channel, ret);
> 
> This message is confusing. Something like "Failed to enable channel %d:
> error %d" would be much better.

Will fix in v3.

> > +fail_pm:
> > +	pm_runtime_disable(ina->hdev);
> > +	pm_runtime_set_suspended(ina->hdev);
> > +	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
> > +		pm_runtime_put_noidle(ina->hdev);
> 
> The count here doesn't match the count above if some channels
> are disabled, or if the enable loop above aborted.
> 
> > +	/* Decrease the PM refcount */
> > +	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
> > +		pm_runtime_put_noidle(ina->hdev);
> > 
> As above, this doesn't take disabled channels into account. Maybe that
> doesn't matter; if so, there needs to be a comment indicating that
> negative use counts don't matter. If that is the case, make sure that
> this is acceptable use of the pm API (if it works but is not documented,
> the PM core may change and complain about it at a later time).

The API will stop decrease at 0. But I will see if I can explicitly
loop a matched number, or at lest will mention this in comments.

Thanks
Nicolin
