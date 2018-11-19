Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AFF20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="f+U1n4lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AFF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeKTI4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:56:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40430 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbeKTI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:56:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so51467872qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ChrHpLCAlgKW98ZZQWgvZT7uaNwjORDbt49QnZXL0AY=;
        b=f+U1n4lStu2OceqxbH1kZ6rlfZNJ+aVTJ8+JVmujzO6KduTEp0GPjfuYBo+5y3rMF9
         jagC++7Rl7XXLIqWEf0qIWXXlZMC9/mmpQzNM9F6PWJd+mgmxo8+LCf+kykLfpyB6eC6
         SQ576W3wULMHpCw3ieKrXQ/9jNYVfAJok3//gLZeboRj2uKNbLRIYxJkEWxg6jvPba03
         iG6ZkhfbyGoOs5KMdYKSV8GJIpIaN8LbS8LxjBKbz5BR29lAokp9sGWF+pq3dwXL393N
         OIHh8fFTtpqoirQ/ZYhqx6Y1h1FZMDNPw6tQ5lXo1Y9AVL1YVxOs7xxVueS44QJOKECr
         xv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ChrHpLCAlgKW98ZZQWgvZT7uaNwjORDbt49QnZXL0AY=;
        b=lUNopQlTUKOZNl46X8zh23MkOZfduS9ytVQh3QtlnNevYY2RRxjvNsJsDddHtbJcIs
         p6NRCjSvKk1/s7mU05G/ieGOKe9H9JeKfk48y9awTlpQTzNeIo2bBd6+fOLrxdiycWtR
         zvXdoc+3VoYpMuvykLUiksFFEf2elLzylX9LFDfLkukqlsoGOEQChEetlJMllway65hM
         7vQhom/gcvQM4jjDzACTr+TixOIk6zajDV5SnrPn5T432w58EpFIFH+OfxEJfLOWkGTz
         YWbVJBouP2jDtYfL8hpBvB8+eysSMrq+klosUPTPWSp4xwtn9JTksFf00ziXUzKeAWJC
         ZdJw==
X-Gm-Message-State: AGRZ1gIT5mCHfNdoeYTRa1dp/BrrePd2GF5WHFXNeJfExiqUuwHDWcOZ
        2sJhHucgfoteYYZ3I7C1bUKn1Q==
X-Google-Smtp-Source: AJdET5fIqbUqyZE1qNs3gMWz00HN9zocoaWlrK5lttwJ/DOOOCF5fEoNgo+v1zqKc2u6CGoS4fW5qA==
X-Received: by 2002:a0c:ace4:: with SMTP id n33mr23623350qvc.79.1542666649315;
        Mon, 19 Nov 2018 14:30:49 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 21sm1682005qkr.89.2018.11.19.14.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:30:49 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:30:45 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: Re: [PATCH net-next 3/8] net: hns3: Add "FD flow table" info query
 function
Message-ID: <20181119143045.5a147396@cakuba.netronome.com>
In-Reply-To: <20181119211845.23168-4-salil.mehta@huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
        <20181119211845.23168-4-salil.mehta@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 21:18:40 +0000, Salil Mehta wrote:
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
> new file mode 100644
> index 000000000000..be7d0dea06e7
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
> @@ -0,0 +1,12 @@
> +*************** int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
> +*** 800,803 ****
> +  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
> +  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
> +  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
> +  #endif
> +--- 800,804 ----
> +  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
> +  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
> +  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
> ++ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
> +  #endif

You probably don't need this.
