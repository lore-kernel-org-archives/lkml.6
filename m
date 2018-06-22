Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D62475F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TxbgOTm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5D62475F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeFVSoV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:44:21 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33928 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeFVSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:44:19 -0400
Received: by mail-qt0-f181.google.com with SMTP id x10-v6so450416qto.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=4nMDHsSU1sy4DoB6uprOXIgpC1jqmwDUQB8P4Bz9+WE=;
        b=TxbgOTm27rOqyGbEIML4121VDbyTWLBdfBQhrxJ6ufs0k0fkcZARKian5SgE64YhDg
         JiQpmi358S4Ad9/Ett77R7UGXKQGRzA8zEYrIsCZw2AZBYyDgNy9yu9cpfXoIK9ySIh/
         UxXCrgayx8SUi7/Pq1mhQRfQ7XKoTaA3ZlzyUsRey8LjBJZAKZNYpnxiBTttu/clxUHp
         MTKEOvutFcWDylzjXKTpm8YELCNFy3Rna4G09J0XZaQEEIn8nZ6vpfhh+Apz6SQwAzjG
         5n+VRHkPrZHtozfqO+XumG8NZzoPy/4WyM4HGnTt3hoKQqpgEQl857rbimU+esUFMPGL
         oy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4nMDHsSU1sy4DoB6uprOXIgpC1jqmwDUQB8P4Bz9+WE=;
        b=G2WarKxmEACPgtoOqccX9yEMxVBEdGyJ9hv5pl6yKWqN0bksoe0RVyRaxUqPoSpOaW
         yamFU36Pu2GMXXwblrUNhMvB88hupiyYKP/RzIx+03me1mLHUNHljhUj7WSWJgD9GNrN
         CANuTdNQIRm/O/UMC8Hlpa02Se2ne57wv6M3j4OrQ5+OmhrD6RjT2PAHqefBAeFyQXe7
         JKdcoPPxRIj4fMiKFcMByC/9oX7+mNZFmsccUImF4ZkVCUmQMXTKFM8Q/TSAXiPZaBb2
         AA1JfgYlFFstUNhPETnF6qn1oxWtcp4vT2fu04wTTpp4FOFyDXbZmivMCCNTsxDf8Oro
         +ilg==
X-Gm-Message-State: APt69E1jJz5gO1SZgP1o5INfkCzBMSMLUsCqnn8eswB1htuiN86eBh5T
        gEP2V4SgJW53288tu1R3Mb9YEw==
X-Google-Smtp-Source: AAOMgpdr6+N4NH15h/Gw+xbFNKELSbI16Lv5OlpKeiflgLvwIoGPidLsjdV1pohu9MTZ4EYkSalE5A==
X-Received: by 2002:a0c:8c8a:: with SMTP id p10-v6mr2522296qvb.68.1529693059215;
        Fri, 22 Jun 2018 11:44:19 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id b15-v6sm5356180qkc.90.2018.06.22.11.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:44:19 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:44:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622114416.23ff14b9@cakuba.netronome.com>
In-Reply-To: <a598aea7-e967-1779-5092-937565a69c0b@netronome.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <3db6047a-101a-2ed1-9ca3-9e90b45ea00f@netronome.com>
        <20180622102428.GA3050@w1t1fb>
        <a598aea7-e967-1779-5092-937565a69c0b@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 11:39:13 +0100, Quentin Monnet wrote:
> 2018-06-22 11:24 UTC+0100 ~ Okash Khawaja <osk@fb.com>
> > On Thu, Jun 21, 2018 at 11:42:59AM +0100, Quentin Monnet wrote:  
> >> Hi Okash,  
> > hi and sorry about delay in responding. the email got routed to
> > incorrect folder.  
> >>
> >> 2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>  
>  [...]  
> >>
> >> Hexadecimal values, without quotes, are not valid JSON. Please stick to
> >> decimal values.  
> > ah sorry, i used a buggy json validator. this should be a quick fix.
> > which would be better:  pointers be output hex strings or integers?  
> 
> I would go for integers. Although this is harder to read for humans, it
> is easier to process for machines, which remain the primary targets for
> JSON output.

+1
