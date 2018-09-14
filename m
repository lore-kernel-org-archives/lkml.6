Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD0ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C1B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkfXL1PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C1B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeINTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:25:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36917 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeINTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:25:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so7638635ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DAS1HNah+IOU+/z97kcCt5b3HQIt3m1OTQou4HJ7M1k=;
        b=XkfXL1PJ0feuSoTapJdvWZRA5Dm6fZuILTTvaBKZzBSwp9PilZOGtyitJUJCG9sk+j
         aMII3WJ342YohRJDPqS8Tls6rj7QX14YaM/HgXvs3JM/D75FdyTUM9x4n1pg1mm74Vqk
         VcBW/I4LeEv3OQhX5jhAaudSSLs/n+zrb2ReScJJHjXhKOx5n0SriGcGzLt4GP13t2N4
         8djsU8nTdyzxTgTPSYe5FmQfh5Xf8qQf+GwtWZF7B+lF/gpUlQqqgQ1CXf3yXxC0Gb+s
         kPSG+J1FH17x/S6MBwUUnHd2lfSTwKbtMhrv3RtOOTq3anc8PG0FZ7mXW+ejB7dD5haG
         P1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DAS1HNah+IOU+/z97kcCt5b3HQIt3m1OTQou4HJ7M1k=;
        b=ORCEJMGbMu9Esvm5M/xPw4/yEPIxSEeXIqYe3yhR5bNQnP+HuMwxbdoY37f5WtR1fk
         lyOulL5S8e6OnudAKuT5SUHvJcl0EnyyUgyoDnJQdWjb+iMQb9SYSHAUGoplCv3Y8q+2
         xlRbWXSmSyKJdMR8tWDCizqbfNaOP/h5LoMyRPji6zjBA3St4CTEFL/0ATpqAMRKPxbk
         hStxywurDZfLXMUAPTyNb8vhzUFSX+v8PUW2TdGiMkIoLnXkYtrwJl9UKV1FeWELn7Ms
         PKBf9ktbM3zc2BPbnRgKUEL7NRNMQXCKr2G/7bN5/nzqLxj+0f6oMHGiNbWYJ6kmMyMq
         l/cw==
X-Gm-Message-State: APzg51DfIMrcZIEPlXuTATYlhaz+jN3EzlSsmqrdsMSxlKcYM26dtN8m
        0B3SdUeR1mpj27mADne2Eas=
X-Google-Smtp-Source: ANB0VdbJUear20Rb9C6sgLY4vPplCvAmXsQQ5m4lrJDLWGMlrQh1xCVd8UM13GHuPqULA+TLt+4fYw==
X-Received: by 2002:a2e:5bd5:: with SMTP id m82-v6mr8402331lje.115.1536934223068;
        Fri, 14 Sep 2018 07:10:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x30-v6sm1266610lfg.15.2018.09.14.07.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:10:22 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0ong-0005rL-Rw; Fri, 14 Sep 2018 16:10:24 +0200
Date:   Fri, 14 Sep 2018 16:10:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/50] ssu100: switch to ->get_serial()
Message-ID: <20180914141024.GR1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-30-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-30-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:29AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
