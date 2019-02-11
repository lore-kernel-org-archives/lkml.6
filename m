Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77627C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33828218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLzFIQl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfBKRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:53:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45135 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfBKRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:53:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so4765269edh.12;
        Mon, 11 Feb 2019 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UbrUFULbMIQcD46SSgeeRTz74tZ2V0OTNnfsbSbO4bY=;
        b=hLzFIQl003x9Rbmara6bFodb3yfzyxLPkWgkT6ByZ8weaCOnA1bgB4bCu8p2rzYVSK
         Cpn9wfXmp9xc2LRL2RIkNFWiEnh7IiXwCJ4RQrq5xNnNYgwvQqjIpmd6UJOpZ+N+frUx
         ld9fvz3Stb/QNwK7KAVL0k3abz65R1AJ9Tww0SIX9rJPsSrA/CBxEdCIsY2hkuCKSACV
         yBh5CMfHT3iDFjcnz1BaSUybEEsssWGIKw2bcIu8jgFv1CaXO3nnI3rcu6lHq3ZEiSZ+
         THkB9w1nnOx47S0CbahroJ4BZUSwxuyladNJwKXw8dQ7J9txHXW4RhwDOdehRNi2Ls3f
         8xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbrUFULbMIQcD46SSgeeRTz74tZ2V0OTNnfsbSbO4bY=;
        b=WgmgYI0VM5Z/KGNdi9Db9JjIcO9myq9AT/I0BzXLYBO8onae7k3oKePdwRvq5Cor6N
         x0ZcDRgJM/av9fX/TTMQTx0Ax2pa5vEkWDqmOCHumjYvYwp1QphdVi3tYbkSZW2oBHMS
         fYAvQofCLcuVqTGgpt3A0Lzf91Cs/jL/aj3+atkRbZIJtz8G5EaywXte9j1IJ+GZqakb
         5xxS+PUU45eW6BHJjJGjyWqPVmA7JBwY3aqnPYaMP6yE+ApRi1RpIgcztUoeRlWyW+pJ
         Yeonlz7FIzcnfKSoGnaItVMTOVzKRqUL/u/e1q3Siibj2L3i+NEZa0hHCtTaOF5s/9hc
         /jOA==
X-Gm-Message-State: AHQUAubyO0aOJ94Ng1piRvaOlkZ0GuHHYnJhH8WbnhJY5swpwlteDfUG
        CHf+pQjIqZdDBRlSxphqmNDJ+Rgbca0=
X-Google-Smtp-Source: AHgI3IbSwczsmVijqV4FtMBVuNpsaLl9vA+1JY1xwxR7iLpxnujjDB/pji/uEYdj3NZccF8aMUQUNA==
X-Received: by 2002:a17:906:1343:: with SMTP id x3mr17893557ejb.76.1549907588992;
        Mon, 11 Feb 2019 09:53:08 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id c14sm3077654eds.73.2019.02.11.09.53.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Feb 2019 09:53:08 -0800 (PST)
Date:   Mon, 11 Feb 2019 10:53:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@credativ.de>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        QLogic-Storage-Upstream@cavium.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH RFC v2] fcoe: make use of fip_mode enum complete
Message-ID: <20190211175306.GA16698@archlinux-ryzen>
References: <20190211170751.1687-1-sedat.dilek@credativ.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211170751.1687-1-sedat.dilek@credativ.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 06:07:51PM +0100, Sedat Dilek wrote:
> From: Sedat Dilek <sedat.dilek@gmail.com>
> 
> commit 1917d42d14b7 ("fcoe: use enum for fip_mode") introduces a separate
> enum for the fip_mode that shall be used during initialisation handling
> until it is passed to fcoe_ctrl_link_up to set the initial fip_state.
> That change was incomplete and gcc quietly converted in various places
> between the fip_mode and the fip_state enum values with implicit enum
> conversions, which fortunately cannot cause any issues in the actual
> code's execution.
> 
> clang however warns about these implicit enum conversions in the scsi
> drivers. This commit consolidates the use of the two enums, guided by
> clang's enum-conversion warnings.
> 
> This commit now completes the use of the fip_mode:
> It expects and uses fip_mode in {bnx2fc,fcoe}_interface_create and
> fcoe_ctlr_init, and it explicitly converts from fip_mode to fip_state
> only at the single point in fcoe_ctlr_link_up.
> 
> To eliminate that adding or removing values from fip_mode or fip_state enum
> break the right mapping of values, all fip_mode values are assigned to
> their fip_state counterparts.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/151
> Fixes: 1917d42d14b7 ("fcoe: use enum for fip_mode")
> Reported-by: Dmitry Golovin "Twisted Pair in my Hair" <dima@golovin.in>
> CC: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Nathan Chancellor <natechancellor@gmail.com>
> CC: Hannes Reinecke <hare@suse.com>
> Suggested-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
> 
> [ v2:
>    - Based on the original patch by Lukas Bulwahn
>    - Suggestion by Johannes T. [1] required some changes:
>      + s/case FIP_ST_VMMP_START/case FIP_ST_V*N*MP_START
>      + s/return FIP_ST_AUTO/return FIP_MODE_AUTO
>    - Add Link to ClangBuiltLinux issue #151
>    - S-o-b line later when there is an OK from the FCoE maintainers
> 
> NOTE: Compile-tested against Linux-v5.0-rc6 with LLVM/Clang from Git with
>       experimental asm-goto support via executing:
>       $ make V=1 CC=clang-9 HOSTCC=clang-9 drivers/scsi/fcoe/
> 
> [1] https://marc.info/?l=linux-scsi&m=154745527612152&w=2
> 
>   -dileks ]
> 
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c  |  2 +-
>  drivers/scsi/fcoe/fcoe.c           |  2 +-
>  drivers/scsi/fcoe/fcoe_ctlr.c      |  4 ++--
>  drivers/scsi/fcoe/fcoe_transport.c |  2 +-
>  drivers/scsi/qedf/qedf_main.c      |  2 +-
>  include/scsi/libfcoe.h             | 22 ++++++++++++++++++++--
>  6 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> index 2e4e7159ebf9..a75e74ad1698 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> @@ -1438,7 +1438,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cnic_dev *cnic)
>  static struct bnx2fc_interface *
>  bnx2fc_interface_create(struct bnx2fc_hba *hba,
>  			struct net_device *netdev,
> -			enum fip_state fip_mode)
> +			enum fip_mode fip_mode)
>  {
>  	struct fcoe_ctlr_device *ctlr_dev;
>  	struct bnx2fc_interface *interface;
> diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
> index cd19be3f3405..8ba8862d3292 100644
> --- a/drivers/scsi/fcoe/fcoe.c
> +++ b/drivers/scsi/fcoe/fcoe.c
> @@ -389,7 +389,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
>   * Returns: pointer to a struct fcoe_interface or NULL on error
>   */
>  static struct fcoe_interface *fcoe_interface_create(struct net_device *netdev,
> -						    enum fip_state fip_mode)
> +						    enum fip_mode fip_mode)
>  {
>  	struct fcoe_ctlr_device *ctlr_dev;
>  	struct fcoe_ctlr *ctlr;
> diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
> index 54da3166da8d..a52d3ad94876 100644
> --- a/drivers/scsi/fcoe/fcoe_ctlr.c
> +++ b/drivers/scsi/fcoe/fcoe_ctlr.c
> @@ -147,7 +147,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
>   * fcoe_ctlr_init() - Initialize the FCoE Controller instance
>   * @fip: The FCoE controller to initialize
>   */
> -void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_state mode)
> +void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
>  {
>  	fcoe_ctlr_set_state(fip, FIP_ST_LINK_WAIT);
>  	fip->mode = mode;
> @@ -454,7 +454,7 @@ void fcoe_ctlr_link_up(struct fcoe_ctlr *fip)
>  		mutex_unlock(&fip->ctlr_mutex);
>  		fc_linkup(fip->lp);
>  	} else if (fip->state == FIP_ST_LINK_WAIT) {
> -		fcoe_ctlr_set_state(fip, fip->mode);
> +		fcoe_ctlr_set_state(fip, (enum fip_state) fip->mode);
>  		switch (fip->mode) {
>  		default:
>  			LIBFCOE_FIP_DBG(fip, "invalid mode %d\n", fip->mode);
> diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
> index f4909cd206d3..b381ab066b9c 100644
> --- a/drivers/scsi/fcoe/fcoe_transport.c
> +++ b/drivers/scsi/fcoe/fcoe_transport.c
> @@ -873,7 +873,7 @@ static int fcoe_transport_create(const char *buffer,
>  	int rc = -ENODEV;
>  	struct net_device *netdev = NULL;
>  	struct fcoe_transport *ft = NULL;
> -	enum fip_state fip_mode = (enum fip_state)(long)kp->arg;
> +	enum fip_mode fip_mode = (enum fip_mode)(long)kp->arg;
>  
>  	mutex_lock(&ft_mutex);
>  
> diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
> index 9bbc19fc190b..9f9431a4cc0e 100644
> --- a/drivers/scsi/qedf/qedf_main.c
> +++ b/drivers/scsi/qedf/qedf_main.c
> @@ -1418,7 +1418,7 @@ static struct libfc_function_template qedf_lport_template = {
>  
>  static void qedf_fcoe_ctlr_setup(struct qedf_ctx *qedf)
>  {
> -	fcoe_ctlr_init(&qedf->ctlr, FIP_ST_AUTO);
> +	fcoe_ctlr_init(&qedf->ctlr, FIP_MODE_AUTO);
>  
>  	qedf->ctlr.send = qedf_fip_send;
>  	qedf->ctlr.get_src_addr = qedf_get_src_mac;
> diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
> index cb8a273732cf..38bb5b798a81 100644
> --- a/include/scsi/libfcoe.h
> +++ b/include/scsi/libfcoe.h
> @@ -79,12 +79,30 @@ enum fip_state {
>   * It must not change after fcoe_ctlr_init() sets it.
>   */
>  enum fip_mode {
> -	FIP_MODE_AUTO = FIP_ST_AUTO,
> +	FIP_MODE_AUTO,
>  	FIP_MODE_NON_FIP,
>  	FIP_MODE_FABRIC,
>  	FIP_MODE_VN2VN,
>  };
>  
> +static inline enum fip_mode fip_state_to_mode(enum fip_state state)

Hi Sedat,

You added this function but you didn't use it anywhere. I think Johannes
wanted this function to be used instead of all of the places where
you/Lukas changed the cast or raw enum value so that the conversion
still happens but it's explicit.

I think we'll need two versions of this function, one that goes from
state to mode and another that goes from mode to state as both
conversions happen (x86 allyesconfig build in drivers/scsi/):

drivers/scsi/fcoe/fcoe.c:2225:39: warning: implicit conversion from enumeration type 'enum fip_mode' to different enumeration type 'enum fip_state' [-Wenum-conversion]
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:2363:51: warning: implicit conversion from enumeration type 'enum fip_mode' to different enumeration type 'enum fip_state' [-Wenum-conversion]
drivers/scsi/fnic/fnic_main.c:774:31: warning: implicit conversion from enumeration type 'enum fip_mode' to different enumeration type 'enum fip_state' [-Wenum-conversion]
drivers/scsi/fnic/fnic_main.c:785:31: warning: implicit conversion from enumeration type 'enum fip_mode' to different enumeration type 'enum fip_state' [-Wenum-conversion]
drivers/scsi/fcoe/fcoe_ctlr.c:153:14: warning: implicit conversion from enumeration type 'enum fip_state' to different enumeration type 'enum fip_mode' [-Wenum-conversion]
drivers/scsi/fcoe/fcoe_ctlr.c:457:33: warning: implicit conversion from enumeration type 'enum fip_mode' to different enumeration type 'enum fip_state' [-Wenum-conversion]

Let me know what you think,
Nathan

> +{
> +	switch (state) {
> +	case FIP_ST_AUTO:
> +		return FIP_MODE_AUTO;
> +	case FIP_ST_NON_FIP:
> +		return FIP_MODE_NON_FIP;
> +	case FIP_ST_ENABLED:
> +		return FIP_MODE_FABRIC;
> +	case FIP_ST_VNMP_START:
> +		return FIP_MODE_VN2VN;
> +	default:
> +		WARN(1, "Invalid FIP state");
> +	}
> +
> +	return FIP_MODE_AUTO;
> +}
> +
>  /**
>   * struct fcoe_ctlr - FCoE Controller and FIP state
>   * @state:	   internal FIP state for network link and FIP or non-FIP mode.
> @@ -250,7 +268,7 @@ struct fcoe_rport {
>  };
>  
>  /* FIP API functions */
> -void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_state);
> +void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_mode);
>  void fcoe_ctlr_destroy(struct fcoe_ctlr *);
>  void fcoe_ctlr_link_up(struct fcoe_ctlr *);
>  int fcoe_ctlr_link_down(struct fcoe_ctlr *);
> -- 
> 2.20.1
> 
