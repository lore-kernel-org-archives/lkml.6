Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eJdCHKu0GltmKAAAmS7hNA
	; Fri, 08 Jun 2018 16:54:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3594A607DC; Fri,  8 Jun 2018 16:54:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1IbrTMu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94471605A5;
	Fri,  8 Jun 2018 16:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94471605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeFHQys (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:54:48 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55751 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeFHQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:54:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id v16-v6so4465247wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MFKr/fFnLbQ27V8jyvG9O46O0Y7SHPFoh5EPZaGbezE=;
        b=M1IbrTMu2KTfXSDo9bonUxkqEOx9SMGj85LTtKjYFHzK55Qa0BFVTDdQuPrMrbNDx/
         jb3rKMPjjy4pLswwPrOP0Ek32GkVk5I66AYiYGBsSUXP033czBYjk7pb5lLccu5P0eCd
         yE/K0245C8uSAk4CK/EbmENhTBgkQ3tkZPEC1NR5MXfaddhsXh0Wej9dJI3LM5VDoz3Z
         2QL/juy6x1gGQ0zkg+ByrRJ5/lqjUS43VZVWCq/HXUDGGyhbC0Rphs/14U5FwT92/AcU
         G4DQwl3pVbcIv8ZMwgz/PGHYD5FuNqwOT77EsCshF5sj8l8vyLpO8cGtSW2vdbMzlPfy
         5BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MFKr/fFnLbQ27V8jyvG9O46O0Y7SHPFoh5EPZaGbezE=;
        b=pB2zmo4TwOGti46G8eOOFBA3mthGkkzCjpSybhWFKGPLb89xAppyWW5kh7PQvlj2AF
         6DZyd9xSuZLqsPalr5fcxlxo+BBcd+yx9nhM44JHjPPCxPQl2Bu4ARuyov9fJJFMp1lN
         yAHGQe1UBWQWYvNGGyFG6UHWc4VSCznA/G33IuTm8Yps/L2m4sSvJkhKMA6qlsdH8sP0
         u3orclQHm+PstAKNyUw2SM7d7Qcm3nilAP5DD9asnci/EOMPuxasYeQJvsxLm+CBf25v
         XT6h7WcKji45UtgotRU7yOaR6LAysMi2L56778hCFFM0lS0Xs11oDUO+Wn+cU+gMWdsE
         cAow==
X-Gm-Message-State: APt69E0obWGskhMwgAHHlYNDzl1nWggLJhFKknrvawWaK4/enOtDWhNC
        nIGfgRM5CyVg6f36i0K8FFVa
X-Google-Smtp-Source: ADUXVKL/XjVJY8Ah6jyuODhaVabhEL05H1xRISRpxKwdBMDboC4vPCxHMQa4yVv5C/8pJAGPt0AW/A==
X-Received: by 2002:a1c:5790:: with SMTP id l138-v6mr2112299wmb.126.1528476886624;
        Fri, 08 Jun 2018 09:54:46 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id p6-v6sm27610572wrq.19.2018.06.08.09.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 09:54:45 -0700 (PDT)
Date: Fri, 8 Jun 2018 19:54:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: 4.17-ad1: -march=native support or Kernel Ricers wanted
Message-ID: <20180608165443.GA2057@avx2>
References: <20180604212646.GA10078@avx2>
 <201806081409.ojn6yi1Q%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201806081409.ojn6yi1Q%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:34:36PM +0800, kbuild test robot wrote:
> url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/4-17-ad1-march-native-support-or-Kernel-Ricers-wanted/20180605-090623

>    execvp: scripts/march-native.sh: Permission denied

You patch application scripts ignore +x
