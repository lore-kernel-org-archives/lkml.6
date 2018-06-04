Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeFDRwq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:52:46 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38183 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFDRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:52:44 -0400
Message-ID: <1528134761.2289.45.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Sriram R <srirrama@codeaurora.org>
Cc: stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Mon, 04 Jun 2018 18:52:41 +0100
In-Reply-To: <20180514064755.718467503@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
         <20180514064755.718467503@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> 
> commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> 
> Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> rx_hdr_status is not padded to align in 4-byte boundary. Define a
> new hw_params field to handle different alignment behaviour between
> different hw. This patch fixes improper retrieval of rfc1042 header
> with QCA4019. This patch along with "ath10k: Properly remove padding
> from the start of rx payload" will fix traffic failure in ethernet
> decap mode for QCA4019.
> 
> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]

I'm curious as to why this backport doesn't include the change to
ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
new field is a dependency for the following patch, but shouldn't the
fix included in the upstream commit also be applied to 4.4?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
