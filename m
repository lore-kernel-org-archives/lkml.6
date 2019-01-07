Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD1C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19E5206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546875346;
	bh=DpoNbvVv5z6gge/pvxbOvc1WsNFdGviyatvt55u6EFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SnniRw7Q11Ck3pjTG8zQIPG7gZRgxTMJ29GbIviL2q0tJQIMqYNUdEkkgolfLHEth
	 mRy13wSBk2ooZZG+Ctdtcp5UBbyS9F9tLJ3rVmb0cKbBB5SqHmQF525I9Edcoy7zGf
	 N2KtX46lgpREdfKUsOK82cvo1SpB8hOO2EVzeJNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfAGPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:35:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43441 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfAGPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:35:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so666238lji.10;
        Mon, 07 Jan 2019 07:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrHZWH2gp5dQS5oNDLNu8kQj0Oa5+63+557GDr1n0hE=;
        b=BmHwUq5dVKd214oJW8N41qc4iqMh0/89X5rgEBP3ttf6TCd8+/IyfeeIpxX0vwJwBt
         vtcjoB6qcJo5V4h0XvfvneavnhQOlb3sGiy7wzsqeTLVzBWW1TdJxuOMRmKZcfvUmkjq
         dalKULxg6QaQX/DNiitM7sStnPtb5tiblgSiT9PaDCjR/jwr2Oqc7hK3pWH+/AMp8Llg
         GZpyNgTHsh8/wftGea9ao6Wt2KfsFU/WsuxjKCuT0M1mgbLyquVR8+Uu2d35fwXGKyhl
         H5EYNQ8hk/zjljml0UXL4P+E8fhg4DU7W69kRNUkUJNi/DSusRbhRie0kqdKLHwiPFPx
         TtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrHZWH2gp5dQS5oNDLNu8kQj0Oa5+63+557GDr1n0hE=;
        b=FJmSF6p5IEMXnv0oNLaocrj6qM6kAz3D6k8ZbWgiw8lle0qRBEORJgEL8T6xySC7CF
         6pYeKvBtBZygGfGJJxkWvLmABMRI+YQKVIwZiFVjzoFYJmGbqtBeUpairS31UGVRJ+E3
         XQtDeDwAUIAQ/aJT40uj3WnZi3ZvEKhEUsmksmYFp6bOLsAQJqjWR6bgK/c3JH6TUi1n
         R3KH7JLR6mKMFdM5J7+EtHvVX/kHUccPEMibWUXJe6sy92FlMjKbmtg4mBIoxikENIGg
         0Wl+ccFfUbWNoBeipu++ghFU2RJsGSBRf9i+UjbHUoJvXYmCU7jmNsJ05fGDLtR1iLha
         c2dg==
X-Gm-Message-State: AA+aEWY9AqpaqBFmqQUvokjXuSY0Z++O0OeGFEdaF1Ye18tumcqnxmXi
        bjAXaPD4q5b8HBKN5xqc4LE=
X-Google-Smtp-Source: ALg8bN6c/JKb+tg99y21WiMnszq1sEAIx5J1Kn0yGJHSiXPqv/s0ULlNWMXVq2BOHPp6P44vb1ZHwA==
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr38436644lji.90.1546875342439;
        Mon, 07 Jan 2019 07:35:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x16sm12378597lff.26.2019.01.07.07.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:35:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ggWwI-0003YS-0a; Mon, 07 Jan 2019 16:35:42 +0100
Date:   Mon, 7 Jan 2019 16:35:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: chemical: add support for Plantower PMS7003
 sensor
Message-ID: <20190107153542.GD14782@localhost>
References: <20190106171614.12615-1-tduszyns@gmail.com>
 <20190106171614.12615-2-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106171614.12615-2-tduszyns@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 06:16:12PM +0100, Tomasz Duszynski wrote:
> Add support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>

> +static int pms7003_do_cmd(struct pms7003_state *state, u8 cmd)
> +{
> +	/*
> +	 * commands have following format:
> +	 *
> +	 * +------+------+-----+------+-----+-----------+-----------+
> +	 * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> +	 * +------+------+-----+------+-----+-----------+-----------+
> +	 */
> +	u8 tmp[PMS7003_CMD_LENGTH] = { PMS7003_MAGIC_MSB, PMS7003_MAGIC_LSB };
> +	int ret, n = 2;
> +	u16 checksum;
> +
> +	switch (cmd) {
> +	case CMD_WAKEUP:
> +		tmp[n++] = 0xe4;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x01;
> +		break;
> +	case CMD_ENTER_PASSIVE_MODE:
> +		tmp[n++] = 0xe1;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;
> +		break;
> +	case CMD_READ_PASSIVE:
> +		tmp[n++] = 0xe2;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;
> +		break;
> +	case CMD_SLEEP:
> +		tmp[n++] = 0xe4;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;
> +		break;
> +	}
> +
> +	checksum = pms7003_calc_checksum(tmp, n);
> +	put_unaligned_be16(checksum, tmp + n);
> +	n += PMS7003_CHECKSUM_LENGTH;
> +
> +	ret = serdev_device_write(state->serdev, tmp, n, PMS7003_TIMEOUT);
> +	if (ret)
> +		return ret;

Beginning with 5.0, serdev_device_write() returns the number of bytes
written before timeout (or being interrupted) so you need to check
against < n here.

Johan
