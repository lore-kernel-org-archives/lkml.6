Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90903ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FDB20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUaG93Vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FDB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeINTXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:23:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36606 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeINTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:23:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so7648900ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4Bhfut1nHrWsFQueVJtY+iJ0vvofFcuh8DKdMRUDQU=;
        b=QUaG93VxuJa8qqGmTjtC0Nd4+mFvPu+zM9/Jq7F9N3iDEVjNMvrYqN6GhAXk2QyY11
         g7NGGfuNlEyVLr5xliAkiEdBQBP9vZSaTM5LX2TjbPk+PZI/eZ83AaR6uzYreL4a8Bfv
         0fQrwPnz+JpcP1TjxaSR+2siFxJz+Hel95SZrQayWn8POU3f6AdxmwNLFy3Ln4NaRikT
         Vra00Enh2UUQJn7Z1jaMlwg43SE5YkLtmqIUwFocXFsVDNqNVsfm/lns53q8CyaKTj9u
         nAWhS1zNzQCExuN/DUaGlDTN1e93eqOCQhGKyOePQdcqmAkFcB/KFIcNwEVzrrvUHY45
         Zc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4Bhfut1nHrWsFQueVJtY+iJ0vvofFcuh8DKdMRUDQU=;
        b=TEBnVsHrxTbWou3RkLi9GrYh+FpzdQu0+hZd/jkKO31r2UILiDYnm5p3g4eQB6Ux8A
         +gaB6C6cUsVu1bC1I4Y54UaWkGAqgfqX5PC/wcNH1TJDlqxh20PQJCl11Fxfd0lqJ0IX
         9MNNoyCV4KBqBz0QneVLRQoWgC1WW7HrTT9d0Mm4EPL4oQ2gDgjlFVrLgBCRWl801Y5/
         PhyaeIDXJOednQyR4f5HQB23qnBac5bgxK2ZRG77RVaTk9C/anYrHUl8Sx2LqIJfG6rS
         DtNQ+prX5GX43Y8fZg5kXmQ1ryjQqT/wHbwN/af5X4SoK6SgWqPiwVFbnJO4zolB3p1D
         hkOw==
X-Gm-Message-State: APzg51Dy+4hHpBO4JzSep5aKPG4f3E1Ll4Wu8N2OZtnJw9dVXgbFjoNW
        wxzza934EUvmqC6jtej3buk=
X-Google-Smtp-Source: ANB0VdaQBeEP8ZAZcrVFJ1DowNGlv0C6psf2rkU6WHtfawSoX3Q3qoyPAqoMXUptCAvs7Z1So5YyXg==
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr7749195ljh.45.1536934134106;
        Fri, 14 Sep 2018 07:08:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1257130lfi.23.2018.09.14.07.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:08:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0omF-0005qT-Ru; Fri, 14 Sep 2018 16:08:55 +0200
Date:   Fri, 14 Sep 2018 16:08:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/50] pl2303: switch to ->get_serial()
Message-ID: <20180914140855.GP1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-28-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-28-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:27AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
