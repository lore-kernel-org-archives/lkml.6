Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561AC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430BF21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098846;
	bh=BrVdYNYYszJhVFPK9o23wgjCHPleqChFkc+lA8V2ASg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C4aqaVU8qpFLbvHh8R1YEY6EuWr67N66XoaPKackOtDebCqATNE55vuGTzUD031Bl
	 Yqn44eKNZ07FYBtEwEkUa7HpiBJaeK71rtxQFqUmpdolJgSNJaj+GwUgZz0mwUZWir
	 KgzRBewrx3xpzsxrLW7FhYFIo+1HaRIEpxyGkgOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAUT1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:27:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34769 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfAUT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:27:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so15479912oie.1;
        Mon, 21 Jan 2019 11:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u78zeQLnEiaEcVYTkjWLiAWx9FjiEZbwxsLUR2wCYxQ=;
        b=qyhIHHuQFnoFr3zTcJTqoRCShtL8e5btfKkrqJiNzgWYfiHiDl5I2Tvp7Uk2PIhaBM
         d95WCpZp8kKaqbcwP8xl8QYPP0le+4NoqG/qE7pKwZyRYtD0Z0d0q0C7DXmgSMmxeUKJ
         Ujn3JjG6NaKFEvm13vA2t/GmgcoIWt1t4ABN3NtW6FtokH6HamA46tGyvzJhX/jbMva0
         DuxE6dIVzrNTspsOaqBmhIAzlycAZPxiDCATuOC3pCLvoRIx/wml1CV6Tb+BNeFV+9P9
         /dqy7dXCtjgFZ5+gleYXcoh4OAMWp1hziGno6ROiQlWMfmEO8er0gHigDIzzah+6rYiX
         2lsQ==
X-Gm-Message-State: AJcUukeLv+OJlOZhAR7+OhixRaSL/fYNBo0JulJJ8iuQk9LdPu+M/Xq3
        ldxQMqVU/hxMQPAgRSX9bg==
X-Google-Smtp-Source: ALg8bN4Z7tf1tIK+kBWnZfOPK9nm3UiiiDfhY740Nd9iZcxDhgbHPH625PZvGV2A7Wv2QKH1GNdFZA==
X-Received: by 2002:aca:3541:: with SMTP id c62mr6111449oia.330.1548098840013;
        Mon, 21 Jan 2019 11:27:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f34sm5894509otb.25.2019.01.21.11.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 11:27:19 -0800 (PST)
Date:   Mon, 21 Jan 2019 13:27:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-lpwan@lists.infradead.org, afaerber@suse.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
Message-ID: <20190121192718.GA8189@bogus>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
 <20190121191420.GA7878@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121191420.GA7878@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:14:20PM -0600, Rob Herring wrote:
> On Tue, Jan 08, 2019 at 05:41:29PM +0900, Ben Whitten wrote:
> > Add basic documentation in YAML format for the sx130x series concentrators
> > from Semtech.
> > Required is; the location on the SPI bus, the reset gpio and the node for
> > downstream IQ radios, typically sx125x.
> > 
> > Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> > ---
> >  .../bindings/lora/semtech,sx130x.yaml         | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> 
> A schema binding. Yay!
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> > new file mode 100644
> > index 000000000000..ad263bc4e60d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: GPL-2.0

Also, I'd like new bindings to be dual GPL-2.0 and BSD-2-Clause if you 
don't mind. This will make it easier to move the schema out of the 
kernel if/when we ever do that.

Rob
