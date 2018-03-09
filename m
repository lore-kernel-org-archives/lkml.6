Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeCIAoH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:44:07 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55532 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeCIAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:44:05 -0500
X-Google-Smtp-Source: AG47ELvoxj+Df1SGDVzeVYq38zJIVek8FQBEWgwVyVF0n5ziAbiF+ZcHtWluqqHpDdconWCJmnK9dA==
Date: Thu, 8 Mar 2018 18:44:02 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, David Brown <david.brown@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: add CONFIG_NET dependency
Message-ID: <20180309004402.GA5910@hector.attlocal.net>
References: <20180222155833.1860318-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222155833.1860318-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:57:38PM +0100, Arnd Bergmann wrote:
> Access to the socket API and the root network namespace is only available
> when networking is enabled:
> 
> ERROR: "kernel_sendmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> ERROR: "sock_release" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> ERROR: "sock_create_kern" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> ERROR: "kernel_getsockname" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> ERROR: "init_net" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> ERROR: "kernel_recvmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!
> 
> Adding a dependency on CONFIG_NET lets us build it in all randconfig
> builds.
> 
> Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/remoteproc/Kconfig | 1 +
>  drivers/soc/qcom/Kconfig   | 2 +-
>  samples/Kconfig            | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Andy Gross <andy.gross@linaro.org>
