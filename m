Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38151C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76572086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iJNmbIpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76572086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeFLSIv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:08:51 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:37289 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934212AbeFLSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:08:43 -0400
Received: by mail-io0-f170.google.com with SMTP id s26-v6so460044ioj.4;
        Tue, 12 Jun 2018 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/smXRsbELwgW1o8QN+zEXhhYi0HdeDbtQxDEaUvVK+g=;
        b=iJNmbIpeYRSHivOTnn38raJPkAmxmaq8tdR6ER2JRneaqZaJP9Due2AY2VsKoFdH+Y
         T1VNQ2GU2Or6vyus6I5h6Y956Bz8X/0bjDSp7puwAq/y2GId2lzk8mE1hbaWCVHW5IFz
         8gR/p1RcUPJ4KT6GnlkrsdMT1+4uSauERIyrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/smXRsbELwgW1o8QN+zEXhhYi0HdeDbtQxDEaUvVK+g=;
        b=jkX9rqPyMyovnGKrV/Ute0bZJJFxZ8P0IjKw3JVd+hdS2VrEHG7jN6pN945xY6dhVd
         11tDoBwkpI2Z6/mZ0sfosHzv85jowEbWBLbxGnkRYTgoZN+r6h+Be4dNSQQEiGVmzRy6
         rQeTIB5i73qXpKI9nxh+EGitYkw877raG9QczZNqPWGPb5ajYyVxtX1YjXZLEJmqkYmz
         A0FRH747Qahw6JiCsiB8+PVvJHdkCP5TSFjmD0gh9bX1cxtChHRihh3QZsIL335LO64x
         wBCvf/NNzBA4/y6W7d7uCTqpFWo0hLRd+bFpteT3DDsVCo3NXEGyKfqeEVmB1s76P8hA
         oMGw==
X-Gm-Message-State: APt69E0ylrPFnrFxEKYnWtnNQshj+yU0OYCribAjEZ1zxImQtaOvnFBH
        9hN865qgz6ycNv9vT0qAzds3mPSb2X7zSkuD6L0=
X-Google-Smtp-Source: ADUXVKIJAloK4CpL7rVfm3N91gggu3ZIYtrjuH3lPiloyfGmOfBSUyYuYuy5MUcYh1fGr8wEpG6kQ3ZlnXmemwxYkco=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr1617798iog.238.1528826922609;
 Tue, 12 Jun 2018 11:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com>
 <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com> <CA+55aFw+2+xCRAaMo8qgvZ7qNgRMo6D=WkwP7APQndG-y5b3dw@mail.gmail.com>
In-Reply-To: <CA+55aFw+2+xCRAaMo8qgvZ7qNgRMo6D=WkwP7APQndG-y5b3dw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 11:08:31 -0700
Message-ID: <CA+55aFz3jmGST_cOB+qH6qZTFa5HJcw2JoeWxJEZdWgeO4=vNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 4.18
To:     trondmy@hammerspace.com, NeilBrown <neilb@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Final note (for now) on this: I've merged the nfs code, but I really
am obviously not happy with these crazy random ad-hoc
cursor-not-cursor list games.

                Linus
