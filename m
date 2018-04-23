Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755791AbeDWPjj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:39:39 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:40958 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755244AbeDWPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:39:35 -0400
X-Google-Smtp-Source: AIpwx4+1n+94QsTbDVLgdGk2nNAKlNi/BhBLrMZcJFDafvsIoWROaKW7E/Z/BKN8rrTcIlDXh1/NgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180419182924.144978-1-swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
References: <20180419182924.144978-1-swboyd@chromium.org>
Message-ID: <152449797393.46528.17202964805765258675@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] soc: qcom: cmd-db: Make endian-agnostic
Date: Mon, 23 Apr 2018 08:39:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NFdimh017097

Quoting Stephen Boyd (2018-04-19 11:29:24)
> +
> +static inline void *
> +rsc_offset(struct rsc_hdr *hdr, struct entry_header *ent)
> +{
> +       u16 offset = le16_to_cpu(hdr->header_offset);

This should be hdr->data_offset instead of header_offset.
