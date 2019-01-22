Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9664C41518
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E47E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548146311;
	bh=Yels/iZ85iSTV7JF/8/1Oh7vzOo6HFLBfFsMpdEH1TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OSuvYxBsv+wlYWcRqtZ6XeXxHmBHLO2M4nuo2XlcNI9+FoWA0FNWeeF7R45SnEZNJ
	 Ganhydf6ZqJACpdeO3i0amZVGUMOxvavd5F9eniRTNNkb6boEi0J7Afqo4nA9vjnEm
	 4lyJ1NrwnITrTDehxNNBqoENeM1iUTHELriMwE24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfAVIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:38:28 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35656 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfAVIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:38:27 -0500
Received: by mail-lj1-f170.google.com with SMTP id x85-v6so19863336ljb.2;
        Tue, 22 Jan 2019 00:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5A13cvB2eg27WOBv14LrmOzzEb6FVY/M7tYu0VplQw=;
        b=ZGXKJL06+IJxd3o8SLe049RBc0JtBcLdXLJ6f0tdtMjH4GqwJV61HcKD8eDBE9eZZq
         eLUyV1ePRmFQ02lYXTKdFwOnETJzMDe7o++QhJ/6sgDufNatFZKW9JY3mbF6uPXtOELP
         CfRhQvVKhPc+xTXViGnYYoahdSBEvhQ+54BwDiApdSBWFdvIlGkiT/2KrRUG1v2xsGQD
         pkXQ5oP/bigU/WXdPTrEXbl/WinwEldskO5/6wtu/ZpI5aLypTuMF1MG+hnMF0vsnCVw
         CWexrjfPZRcQiRepalkmfubzm/rH7kwMqpbRYP+tSv/MRbcZzHmOnNfiDt5FoIuSzgg+
         I+oQ==
X-Gm-Message-State: AJcUukcWCTTOV2iI9IoU8oR3bjsm9D43vW6ekGolnPXTNC7llCTUWO37
        hNGZaPS501VtQgJiWtTeDj6ayqX0
X-Google-Smtp-Source: ALg8bN6mhxPbBGMw5kExugH6oE/xMZKs1SRZbMs/B8ymStn9NecUtW2u//XoUY4lT5YW+s+mCmVJUQ==
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr17817025ljj.120.1548146305381;
        Tue, 22 Jan 2019 00:38:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v64sm2660087lfa.48.2019.01.22.00.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:38:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glrZb-0003LL-Gs; Tue, 22 Jan 2019 09:38:20 +0100
Date:   Tue, 22 Jan 2019 09:38:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190122083819.GP3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-3-andreas@kemnade.info>
 <20190110121038.GA9725@localhost>
 <20190110230223.18ecbd87@kemnade.info>
 <20190114105129.GE3691@localhost>
 <20190114131346.4d476055@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114131346.4d476055@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:13:46PM +0100, Andreas Kemnade wrote:
> On Mon, 14 Jan 2019 11:51:29 +0100
> Johan Hovold <johan@kernel.org> wrote:

> > Good point. Unless we know the current state, we'd need to sleep for
> > HIBERNATE_TIMEOUT before waiting for data reception.
> > 
> > > >      - timeout: failure
> > > > 
> > > >   hibernate:
> > > >    - toggle on-off
> > > >    - sleep(HIBERNATE_TIMEOUT)  
> > > we could also additionally check here for 
> > >    if (last_bytes_received == GOODBYE_MSG)  
> > 
> > Caching and parsing the stream for this could get messy. And is the
> > expected message clearly defined somewhere, or would it be device (and
> > firmware) dependent?
> > 
> I think so but I must check.
> $PSRF150.0
> 
> But as said, these ideas are be for a possibly later patchset.

Yeah, and remember that the receiver can be in binary sirf mode as well,
so this do indeed seem like something that will need to wait.

Thanks,
Johan
