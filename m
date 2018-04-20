Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeDTIMz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:12:55 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37165 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeDTIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:12:49 -0400
X-Google-Smtp-Source: AIpwx4+TtKsofx79ZT7HJ/qO5v84rnOVdFu+lWNyjhEzKYsG74IR/KOfIAFy/2rj3v2fSG05c5B6uw==
Date: Fri, 20 Apr 2018 09:12:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] regulator: ab8500: tidy ab8500_regulator_get_mode()
Message-ID: <20180420081246.zos5mblrna2bsj3l@dell>
References: <20180419100828.GA10724@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419100828.GA10724@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Dan Carpenter wrote:

> The indenting here is confusing.
> 
> Also we don't check "ret".  That isn't likely to cause a runtime issue
> because if it fails here fails then we'd probably return -EINVAL at the
> end anyway.  But it does introduce a static checker warning since "val"
> is only inititialized on the success path.
> 
>     drivers/regulator/ab8500.c:429 ab8500_regulator_get_mode()
>     error: uninitialized symbol 'val'.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
