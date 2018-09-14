Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D9FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182020671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEgTBkKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D182020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeINTYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:24:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42541 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeINTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:24:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so7975536lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhxLeRFR0osE2IsBYMpdj/HJmjTOXwd9a/NQdEbrIv0=;
        b=uEgTBkKxgJ7zk18jCr4nJ9zOpdY6gp+Nx/EC4SPvYpQV3JYHdEqZLDdDE2lnemsOwK
         4JiytkZodGZqv86f2s1LC0WjNpkAwuFUVWuRwyTbmwxAGtwsRX8EGbXRG0YJgEp1egxV
         Pw0cWe+55519IKTe+vmzyoQBtuGdLee1y7qangpNyQKDoTcb+bXWrgtr0mmmJveU8YL7
         iitTsXvwGsS0zSAJr/2kyTJRgqk91g/E4LYkJSwcUjD2esNfvAYuZH/ADMlX8Jo/WtaZ
         Ud317BM0vCQKLfGyuHcwo2Z+eHN0n9vvl5BeD0SuW6c2eYTvKKW3J5S7VEzAkYzN+TCm
         PBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhxLeRFR0osE2IsBYMpdj/HJmjTOXwd9a/NQdEbrIv0=;
        b=mZuibFFwkn1o9f6XZqZmsVybeqRKXuseVJjN6QQyVHEsVW02rc0qWWPJb0UPKm86JU
         CpTwKwfR/QgmWx+KsDFrm1Mp8DOeDsQT5CrtcYKYMvpLQATWzxph4FZF2uoHbXJ3Rfu6
         QvLpO2VIUCUA/Qg4g83AD4Z5NYBB6ipC+NBAVeUNuoTfYs7bo+nQy6TZswZBtAoeneZX
         EldN+cip4doUNgaQDx72JQXVLQtK9Izco2etjad9yB9y34VLv1H3gDOhSVLxSsGRgiyA
         lEHEfG4D5eN/xEkWaVzPTnpkUfcAOtGDCYQPxvYURsrESMCntC6wG3iuXiJBXWXazN2K
         FnDg==
X-Gm-Message-State: APzg51Dq9Q66o3qPSfyuEKptylxbFPCy8RpUibYeIw4lwdnmXoeYxuCH
        j/ECoJLWE47sSNTAHRpOOgSKpo6a
X-Google-Smtp-Source: ANB0VdY9N+2dcYKx9K/SuYHSmQsbAuOfRIuGjJZrfJz/SPSObuRFqNl6VcVY2sJUyc92Hxl7H1VdZg==
X-Received: by 2002:a19:c513:: with SMTP id w19-v6mr198085lfe.113.1536934174217;
        Fri, 14 Sep 2018 07:09:34 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e26-v6sm1208747ljl.67.2018.09.14.07.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:09:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0omu-0005qn-2r; Fri, 14 Sep 2018 16:09:36 +0200
Date:   Fri, 14 Sep 2018 16:09:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/50] quatech2: switch to ->get_serial()
Message-ID: <20180914140936.GQ1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-29-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-29-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:28AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
