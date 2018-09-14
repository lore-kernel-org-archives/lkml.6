Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E81BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C159206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRgomt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C159206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeINS6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:58:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40517 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:58:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so7910451lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1P3z+MABd/HgjSfh2qiQ+SkWmEyrH7VXPs/XVzfH0k=;
        b=fCRgomt1zXn19hOYJqtuwEh5D7oVIIUEaUfBm+O7SnnlsH/1ILeHvvUrPPlwOU33OB
         HEIlen96yMLL5luY6lPQQ9I2/vvkgDr1I213pbJG32IbodeqN+d011PVzMKZna0WpLtB
         3HzagVHoYt73kNnP78So0GzZQMI/A/RC/APW2AgB+8RnS/ZumEm48/sfX0s7DLFbMkD6
         +rnuC7cnQyC9Lcsw4+r1WtrhGSxUOl7QcZmYx6AW6PTmfyEy+AVWG/9m0jFCNL8eazmL
         JeYxjAYQc+g+9YcsqXSgTArZ5r4Qj1u8h3PngkEKy1USBcVYBowRy45fzQ4T7rhEDDdv
         7BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1P3z+MABd/HgjSfh2qiQ+SkWmEyrH7VXPs/XVzfH0k=;
        b=efNzBVar/EGX5VUAb+29rbq0OOk1fowWuDycXYdRPFqNQunvtGhEoWw8Apxc7kLYPd
         +8KzyQ1Ss/bnkWIXhcNZK41/3UNbqMFIwW/90TqwG/fCnvQWGokDz3moxmmKYDLXMwu8
         tdQQ085Jg9sB1s3hkUge4kuoQqfAynpOdy891mlm5x0YZs9CJx+UqALLfybKLWYl25ab
         DSXIdF7CHFGSZj/WUj5KZlQEEDHSLPc86RnEOJd+KV8b/LoonTQ68Q1g5nJajXLuD9qK
         MAYB0F5JJCVP39ciUYTFlW/cr7wwPc7FWd3AI59V4qJvgzqGxEDMyg5TDFMe3B27mKbQ
         m3Hg==
X-Gm-Message-State: APzg51Bd/SmNvo+N4Pvfv8RE+fWTMynXHfMkrJWq/OdPkS1mHHE7qZ5p
        ODoNFAv9nXwoKr3KmezoNYY=
X-Google-Smtp-Source: ANB0VdbW1ZgXvLBYlO1iZaCha/v2S6L5WkvWCWVH/eOA/z+fRqUS0kgmcp0dyPFBUf1py7JEY7RzNQ==
X-Received: by 2002:a19:2841:: with SMTP id o62-v6mr8072097lfo.86.1536932634777;
        Fri, 14 Sep 2018 06:43:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z189-v6sm1273707lfa.14.2018.09.14.06.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:43:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oO4-0002hJ-J4; Fri, 14 Sep 2018 15:43:56 +0200
Date:   Fri, 14 Sep 2018 15:43:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/50] f81534: switch to ->get_serial()
Message-ID: <20180914134356.GI1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-21-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-21-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:20AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
