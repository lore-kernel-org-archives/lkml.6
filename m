Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeBLSoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:44:03 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42324 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeBLSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:44:02 -0500
X-Google-Smtp-Source: AH8x226ryZD//JCNqO4CQR/C+f3Sp10TLMWkp8L3HrmoWMkX/fsB+OXwDbL1n66G6Kp9U0IAS0Ej/g==
Subject: Re: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
Date: Mon, 12 Feb 2018 20:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Currently, we will unquiesce the queues after the controller is
> shutdown to avoid residual requests to be stuck. In fact, we can
> do it more cleanly, just wait freeze and drain the queue in
> nvme_dev_disable and finally leave the queues quiesced.

Does this fix a bug? What is the benefit of leaving the queues
quiesced in shutdown?
