Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbeEWSsi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:48:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35580 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934034AbeEWSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:48:32 -0400
X-Google-Smtp-Source: AB8JxZpT29bfg9G9mCZBqq8PZHE/zVhG4v7cmg52IyCsE7CBaNp+j2U0kZo0LdbfBYUTQacjs7spJg==
Date: Wed, 23 May 2018 13:48:30 -0500
From: Rob Herring <robh@kernel.org>
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] scsi: ufs: set the device reference clock setting
Message-ID: <20180523184830.GA29198@rob-hp-laptop>
References: <1526962900-20683-1-git-send-email-sayalil@codeaurora.org>
 <1526962900-20683-2-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526962900-20683-2-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:51:38AM +0530, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS host supplies the reference clock to UFS device and UFS device
> specification allows host to provide one of the 4 frequencies (19.2 MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> device reference clock frequency setting in the device based on what
> frequency it is supplying to UFS device.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> [cang@codeaurora.org: Resolved trivial merge conflicts]
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  8 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 20 ++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 60 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  2 +
>  5 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..ac94220 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per direction.
> +- dev-ref-clk-freq	: Specify the device reference clock frequency, must be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.

You already have "ref_clk", can't you just read its frequency?

Rob
