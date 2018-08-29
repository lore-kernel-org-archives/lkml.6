Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85710C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD920868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEqo5v6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDD920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeH2P0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:26:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46832 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2P0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:26:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so3635780edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PbcKAH/v3zUFvu9xcQlobSgs+COhQBJiNKVFrrIqq3I=;
        b=hEqo5v6ULQozTcIuei7q73SZijvRGg+bqNRmQVp9AUZ509P8KUB7qs0Gv/9wj5bQOZ
         Sk+X++AkOae/X8Ux2K5HDbvH6vhGrMqKo1JqaLA5eeSFD26I1XrcaxOW4ovPIFt6UNFf
         2unYLqdbX0sKxm8wfEmzYOJFqn4DPfbdSsKOztzAhvxEclWNgROpUG7tQMFcnqxzaZf1
         1cC0PSFmUjpQknJ7Z8jFEekzrDzGHG7/ClnB/4FZ3CU/F/WCINOs5mbvzmwYBx4IPN3e
         PJ5nQFTuJeAPCt5CtYTcm+dsiiQ0TCcEa+2smz9LScGdeDN66j2zNGI8VE/CCL1nBFr6
         Dd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PbcKAH/v3zUFvu9xcQlobSgs+COhQBJiNKVFrrIqq3I=;
        b=UetHOEMlgUNceaaOnhz8eQOslTtQOqRaQT4WNaDWgIHN11mPhowCnDpI3JM4rSfEeH
         OCsAD7LqpiTpO1XBPW6cxVKJcdH6WyiIVpME23XEXlUGaRQCz0bQyqYRE3dRe9g1fWDa
         3g1EfWB0aeA/ZpCdxWfc0zLAowsZ7BItX/IpJehsb1ZIlM5RNTmBQ61MXRiffQpzy9BE
         OEA5a1fEOU/BmJFGxcjrhyMK7tKq4m6258I1DmieKvSpvdMmKE71qMlGGU/jIlFYszi5
         qrsMnIMgzeOyI0fjxmlzC4yxH5mdVxaoLRX5cpxvP+RFfLl0bDadzGJ1Vv2KtDRIfDb9
         j+LQ==
X-Gm-Message-State: APzg51AHe4K/IZO4Uy+rpqhNYbM/1sWknCJ8nYdDBFplt/Bwj6T1dIMJ
        LmfzaSWoct2ybQEw3maB4/s=
X-Google-Smtp-Source: ANB0Vdb06k1JaWrmkiEraoeBdbtvtM4teQ+CYK+7Bjv/U3mbYrpiWqakOPhGPUs4EoIJoxQzG9hskQ==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr6945113edb.237.1535542208517;
        Wed, 29 Aug 2018 04:30:08 -0700 (PDT)
Received: from xux707-tw ([109.77.207.8])
        by smtp.gmail.com with ESMTPSA id d22-v6sm1878589edb.7.2018.08.29.04.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 04:30:07 -0700 (PDT)
Date:   Wed, 29 Aug 2018 12:30:18 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 3/4] staging:rtl8192u: Refactor member variable enabled -
 Style
Message-ID: <20180829113017.GA4670@xux707-tw>
References: <20180828185535.28808-1-johnfwhitmore@gmail.com>
 <20180828185535.28808-4-johnfwhitmore@gmail.com>
 <20180829112032.tbofr3ejrlo3jz6o@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829112032.tbofr3ejrlo3jz6o@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 02:20:33PM +0300, Dan Carpenter wrote:
> Like you mentioned in the 0/4 email, the right thing to do here is just
> to delete all references to ->enabled.
> 

Thank you for your response, I'll do that in a future series of patches.

jwhitmore
