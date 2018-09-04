Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42422C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD0206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQMT4TmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AD0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIEBmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:42:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40200 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeIEBmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:42:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so2269413pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wikch0FHJl2lYkyXSbwjuTBnYhtk7uI/uCyoRvNRvzE=;
        b=jQMT4TmX5yNCdCPxLmV342eZfkagSEE+HYOg8aWtszjQNc2AZLk/BaufJfBX/9ZiNt
         55i09EVwD3b9nDCeYn/Yt3qv//wysUI1q7nmYRVHF8vrjEwgY2DC+YyayT0bqNwPardD
         eZBxXld+6+cXibE/MiDelK4dnmB6XolOArBjBLUWdeWfyIwzIBPHPC99YWEF9+agO+JK
         p/mhBhvTrVgFCJb2PNpTGgcrk4kKYHd4dqTOWh23pwZX9zhrBhoXREzh1DNEhpElQIMD
         hdsgl+jqD52AQthGT228p0/pjgqYsf46H+IIxS906yUPKNK1NmLcJL47uqG0HG/HGjK4
         2ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wikch0FHJl2lYkyXSbwjuTBnYhtk7uI/uCyoRvNRvzE=;
        b=qLzqcpGG6OQEGyJFEoExXnAYc8snNWPd6ls8UQ4zrPolilpuVfRkFMSOxAm08rrJjk
         NIi1izUhAWm4vT1SEOZ5llO9KqBj0ssOM48EJcO2swd3uc7drzb2qEs1V8BsO18ILDcE
         4f4OdoK12exfBCwcsTo/AIZufWxC4H1sWnvZGGnSsvzMZ4lotgUhE5b9MSR97VbzAulU
         IvHNsjXo0YkSHIVjgKuXpkqxLcZIajvMkXqdErR5SAwe/w+6/BD2neLD4TfbKAPoaIlW
         yTRrQIDXt9HFBur/EffkqoKWyOobw2rTe7rOb0CqJLKUT9978L/uunvgXfq9w8EXIB3w
         OL7A==
X-Gm-Message-State: APzg51CP+xwDCnyHVaDzs6edZhYbQSEyUF+nbl4qZVo0NJyuodijLlo1
        Ta0x/wm0Q5kpOQ+4LFigiSQ=
X-Google-Smtp-Source: ANB0VdY2ZOxhfWHbxDVS0q82Ev6+9qRzqIYMoXJw3udnpYenBU05tg/c1ggTfBeFRFmU9FsycoE07g==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr10750324pge.166.1536095739105;
        Tue, 04 Sep 2018 14:15:39 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id m15-v6sm31996441pfj.171.2018.09.04.14.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 14:15:38 -0700 (PDT)
Date:   Wed, 5 Sep 2018 07:15:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
In-Reply-To: <20180904174808.GS335@mellanox.com>
References: <20180904174808.GS335@mellanox.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 11:48:08 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> Hi Nicholas,
> 
> I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> console..
> 
> Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> providing hvc0, using options like:
> 
>         -nographic
>         -chardev stdio,id=stdio,mux=on,signal=off
>         -mon chardev=stdio
> 	-device isa-serial,chardev=stdio
>         -device virtio-serial-pci
> 	-device virtconsole,chardev=stdio
> 
> I see the hvc0 console hang regularly, ie doing something like 'up
> arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> OK.
> 
> Any ideas? I'm not familiar with this code.. Thanks!

Yes I have had another report, I'm working on a fix. Sorry it has taken
a while and thank you for the report.

Thanks,
Nick
