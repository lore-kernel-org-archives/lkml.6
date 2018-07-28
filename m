Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F27C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D052F20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xaAfaGuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D052F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeG1Qaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:30:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45213 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbeG1Qaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:30:55 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so6482901iom.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IwRbCXQ2YaHI1aMdP9cps1U9m+EQOmzTZqBCJ1t7Mq0=;
        b=xaAfaGuogm4cGOqyDZ0PJUeqZdM4laDmXJB3jWtelOfXrVE/l+XC1+mYNvYAqsSsNB
         afP5D7nQxOwDzMD/GQzmk0iG3vGgr6w26AZ3I5LXiDPB//E/YKRC7PzHFBQEzbe5Qa7b
         5T5oRvD3/t5bYTjijPBndrbPqBZx4GcyGf4Oc7nrFflAobfcPw7KySu9FgQCuQAYE4e9
         w77sW7QvouRNE8eNmLgskXEuB6LAakU6T8kqHZsjkVrdrHEeZ3evhbGt6QmxMKRS+eMw
         Q6zpMVdY6M/1fWxiVVpIJtq7LPYNqYzoEGkZgCkYhkxADLYQBg8cCkbn8k2vz31gfFa+
         KqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwRbCXQ2YaHI1aMdP9cps1U9m+EQOmzTZqBCJ1t7Mq0=;
        b=pnPAS9WJZMXirR0KwdTC9G2OZ0ZCtTR/y7Ns7GzP1ZTrtTrFJ7LVbhbjNyGp2XLwuz
         LAtzmqqI88fvdi9+6yGUAa3NAf+/+8/wpIMl8aVbG3qc696d2ANYtkVI1LSgQTrr+lSf
         R5S5Q08EopOTyDXMT9dIEI1vZRtDYJ8KcpMg10SLWqazZ3NIsoyaO6kkK6GoJeMRilvp
         aUDJMSHxZJmMzKXTCfN8N8A1JBIJWeI7mdiQjCBv01lJwELBI+B7wV4JmEzrD+pf0iLa
         dHJizIhfridjP1ADZdWpD93Sao755Jol38EYpFxGFcrw54Tk5aYnLlNilHCR4btYn/dO
         +VgQ==
X-Gm-Message-State: AOUpUlGy0cKXiJmwbxnyDU0uA1LxdhfvXxWKwAicavSW29iqtJoFSAA9
        P7bzlh9nBIWrJrIxo/0cSpUx+g==
X-Google-Smtp-Source: AAOMgpduP3Tg6Guh1ONCf69rJ4DI4uogGnHZkEREBJeeZ1q4d1Kq9iIyK5TfP6nB/+LOA6FeI3RU8Q==
X-Received: by 2002:a6b:bb03:: with SMTP id l3-v6mr9085901iof.212.1532790246607;
        Sat, 28 Jul 2018 08:04:06 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id y25-v6sm4510627ita.17.2018.07.28.08.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 08:04:05 -0700 (PDT)
Subject: Re: [PATCH] fs/buffer: Convert return type int to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        viro@zeniv.linux.org.uk, konishi.ryusuke@lab.ntt.co.jp,
        darrick.wong@oracle.com, dchinner@redhat.com, pombredanne@nexb.com,
        ebiggers@google.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com
References: <20180728095043.GA24085@jordon-HP-15-Notebook-PC>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf0ac658-582e-25a2-3a1d-1046d2c6228f@kernel.dk>
Date:   Sat, 28 Jul 2018 09:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180728095043.GA24085@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/18 3:50 AM, Souptick Joarder wrote:
>  out_unlock:
>  	unlock_page(page);
> +	ret = block_page_mkwrite_return(err);
>  	return ret;

	return block_page_mkwrite_return(err);

-- 
Jens Axboe

