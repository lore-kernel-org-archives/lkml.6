Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF557C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="yI44WtEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbeFLE7t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:59:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34122 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbeFLE7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:59:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so22557712wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Pxl8hyQgwEHhkrm6gi05tW8HT/vtA7BdpXPFVQNcNWs=;
        b=yI44WtEKYq6tiV+Pk1faIwSu2LgMMp9V73vpVsnflSAXamW0cK5vXodpsnXQu25G2L
         iSg0AQakxTQ4ygOKHim8Wf+x4JSqelJ9oE2jIiZZ06SfzgyRv/eNwYj+ahTjvDWQThar
         LUT1zxQWYhOJuUUQujWPjOUmWVsBSpDlgbq8dvIqpkb+lom3fwY1qK5HTf5pkH8zCGx6
         NScR85AAb5RFxzBzwd6WAEzk9kix2C+t0ANFHuuyI2aRcOQhxjBCkNSttTZbFQV5/GHB
         l/tDlLDTyr1sZhrziC31oCiGpH7BJK0UIdApPltBrLR3DD9kTDk3uwGaI4SHf3DGkc9m
         NiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Pxl8hyQgwEHhkrm6gi05tW8HT/vtA7BdpXPFVQNcNWs=;
        b=D6llYnBw24B/Y7CCnzeHzKj+TRqzkiLhtNlQNJemFXlyXS+Q4UQakvlZluhplQblqo
         i8xqmznQqwaO0IbtuenAsI2rX6zMC5yjhNH/TJTwa7XoJn0DR4M9SnrsOXuvstINBiRI
         XJJRv7W2DiyAMGZ0IG1KOyjccsQnJ11mcm1iLj3n4/Vvy7z1rhlYtSudg8u4ZqTylYFy
         WdL+pOMV+lzbKr2cJ+Ctc4yv7pLsCiLQtPDApjVINTo/3F1H9ecWVPKKSDr570qXjZ+k
         xy7t8h18xD0cCgHU/8ZaEYDQJ57Kta7fMKLXgH2x0LwxcU7gjO/ktx1eQwcev04+vH7c
         4c6g==
X-Gm-Message-State: APt69E0Nw9qrBU1Ai3ECf3Cn0UZCuktmG60VA7hN1Nko906h+5fDFE+B
        hgaPACKpdQ20qbBgkOLOTcb2bA==
X-Google-Smtp-Source: ADUXVKIEio/0pLggnvTribwbREe8MFLl7qonscNh6QHguBWVhgVbPVSqTDqWZOMCNIUw7zYpEV+FkQ==
X-Received: by 2002:adf:a0aa:: with SMTP id m39-v6mr1228827wrm.125.1528779586369;
        Mon, 11 Jun 2018 21:59:46 -0700 (PDT)
Received: from localhost ([141.226.165.75])
        by smtp.gmail.com with ESMTPSA id i76-v6sm373984wmd.20.2018.06.11.21.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 21:59:45 -0700 (PDT)
Date:   Tue, 12 Jun 2018 07:59:42 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180612075942.00005061@dev.mellanox.co.il>
In-Reply-To: <20180611161918.GF5815@mellanox.com>
References: <20180608174218.32455-1-willy@infradead.org>
        <20180608174218.32455-3-willy@infradead.org>
        <20180610063028.GH12407@mtr-leonro.mtl.com>
        <20180610104305.GA9284@bombadil.infradead.org>
        <20180610122505.GM12407@mtr-leonro.mtl.com>
        <20180610203027.GF5560@mellanox.com>
        <20180611043425.GA21382@mtr-leonro.mtl.com>
        <20180611044203.GA32562@mellanox.com>
        <20180611091914.00007858@dev.mellanox.co.il>
        <20180611161918.GF5815@mellanox.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 10:19:18 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Mon, Jun 11, 2018 at 09:19:14AM +0300, jackm wrote:
> > On Sun, 10 Jun 2018 22:42:03 -0600
> > Jason Gunthorpe <jgg@mellanox.com> wrote:
> >   
> > > Er, the spec has nothing to do with this. In Linux the TID is made
> > > unique because the core code provides 32 bits that are unique and
> > > the user provides another 32 bits that are unique. The driver
> > > cannot change any of those bits without risking non-uniquenes,
> > > which is exactly the bug mlx4 created when it stepped outside its
> > > bounds and improperly overrode bits in the TID for its own
> > > internal use.  
> > 
> > Actually, the opposite is true here.  When SRIOV is active, each VM
> > generates its *own* TIDs -- with 32 bits of agent number and 32 bits
> > of counter.  
> 
> And it does it while re-using the LRH of the host, so all VMs and the
> host are now forced to share a TID space, yes I know.
> 
> > There is a chance that two different VMs can generate the same TID!
> > Encoding the slave (VM) number in the packet actually guarantees
> > uniqueness here.  
> 
> Virtualizing the TID in the driver would be fine, but it must
> virtualize all the TIDs (even those generated by the HOST).

It DOES do so.  The host slave id is 0. Slave numbers start with 1.
If the MS byte contains a zero after paravirtualization, the MAD
was sent by the host.
In fact, ALL mads are paravirtualized -- including those to/from the host.

> 
> Just blindly assuming the host doesn't generate TID's that overlap
> with the virtualization process is a bug.
> 
Not the case, host mads are also paravirtualized.

> > There is nothing wrong with modifying the TID in a reversible way in
> > order to: a. guarantee uniqueness b. identify the VM which should
> > receive the response packet  
> 
> Sure, as long as *all* TID's sharing a LRH are vitalized like this.
> 
> > The problem was created when the agent-id numbers started to use the
> > most-significant byte (thus making the MSB slave-id addition
> > impossible).  
> 
> It hasn't always been this way? What commit?
> 
Commit: 37bfc7c1e83f1 ("IB/mlx4: SR-IOV multiplex and demultiplex MADs"):

Code snippet which replaces the MS byte is below (file drivers/infiniband/hw/mlx4/mad.c,
procedure mlx4_ib_multiplex_mad() ).
Just an aside:  Oracle noted the problem on the *host*: The host's message log
contained the warning issued on line 1529, with slave=0 (which is the hypervisor).

37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1519)  switch (tunnel->mad.mad_hdr.method) {
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1520)  case IB_MGMT_METHOD_SET:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1521)  case IB_MGMT_METHOD_GET:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1522)  case IB_MGMT_METHOD_REPORT:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1523)  case IB_SA_METHOD_GET_TABLE:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1524)  case IB_SA_METHOD_DELETE:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1525)  case IB_SA_METHOD_GET_MULTI:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1526)  case IB_SA_METHOD_GET_TRACE_TBL:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1527)          slave_id = (u8 *) &tunnel->mad.mad_hdr.tid;
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1528)          if (*slave_id) {
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1529)                  mlx4_ib_warn(ctx->ib_dev, "egress mad has non-null tid msb:%d "
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1530)                               "class:%d slave:%d\n", *slave_id,
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1531)                               tunnel->mad.mad_hdr.mgmt_class, slave);
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1532)                  return;
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1533)          } else
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1534)                  *slave_id = slave;
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1535)  default:
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1536)          /* nothing */;
37bfc7c1e (Jack Morgenstein            2012-08-03 08:40:44 +0000 1537)  }

> Jason 

