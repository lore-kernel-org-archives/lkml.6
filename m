Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526892851; cv=none;
        d=google.com; s=arc-20160816;
        b=YmuKpcs+Vqme9c2SFItatPK35+F7+NhrH0pk+ti+h7q8QY2v8MA1qp1/4EdCNNHQ7E
         WSuL5srv992qRwR/vgMW1xnv7zc707oRk71VSVdbGd4810my8LeeFZReE3z5hPg+ii+T
         rdlyAHDTNUCV37p59m7zUd/+Xe2Ar+Mgf7nOEaMnIqtVeMO6c0XNtEWgrlUCa3/7gYju
         Pnl4y3Fa2Fdln3hpH6W0RofXbAPBrZwGeuCUqrEQAkrsGkrKkBsg+Ms8n1UiMo3Ih26J
         /7hx2jvplkWiO1d/jT+XPa2vf9QBRW0dWA9VafpOk0WMjSY+9Xy2+W1OkMgsKRP3UvFp
         1PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=nn9ybcNLB2n0l8p8fvHoc/7nqnNpXTq/WeUMRCn5m00=;
        b=KmFWt5171RJbgyV/5AR5IIFCObDIY04vdtouHGZq4cppb6Vl+i9Mq/cbuotFgtRLFj
         BWY/ICisqDHVmUshymUPD6MyHYhDZlhtZEXSYohBbdASw1QSo5AtZwXO4TrpFWqJxMtR
         1UPkW+Nuixo+FPBn5okoHSc90ZT9Nl7efuC2j19kOoygf23qrQYXeRNRJoHAxPCJ9D6V
         UyVWQ97PX7SOZUK6jdEhKR7UWqA4CaiojHdI5J5d1rWGmekAaYyZWrXSa1E2q4r/6ChS
         nJrY5L486kfzFfAURSxNpIzfCrUSMM81z8V7HmH2WyH+aysF8LjVPDSFdAXBbyAdWoIe
         9Fxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=eU4NGZ9L;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=eU4NGZ9L;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoNNR4ghuBP18iAHSeTePRpK5Oj8SQ2UkptCTALN1AFcZWeK2XP6H6dzM+CJK4BkZX++6n47A==
Subject: Re: [PATCH 2/2] slimbus: ngd: Add qcom SLIMBus NGD driver
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
 kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, broonie@kernel.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180516165118.16551-3-srinivas.kandagatla@linaro.org>
 <201805190351.kbyN0JPN%fengguang.wu@intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cc6b47dc-2b91-68cf-0c27-b7f72305ba04@linaro.org>
Date: Mon, 21 May 2018 09:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <201805190351.kbyN0JPN%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640410451742727?=
X-GMAIL-MSGID: =?utf-8?q?1601063199239824144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the report!

This patch has dependency on https://lkml.org/lkml/2018/5/17/251

I should have mentioned this in cover letter!

thanks,
srini

On 18/05/18 22:39, kbuild test robot wrote:
> Hi Srinivas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc5 next-20180517]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/slimbus-ngd-dt-bindings-Add-slim-ngd-dt-bindings/20180518-193916
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
> 
> All error/warnings (new ones prefixed by >>):
> 
>     drivers/slimbus/qcom-ngd-ctrl.c: In function 'qcom_slim_ngd_get_laddr':
>>> drivers/slimbus/qcom-ngd-ctrl.c:862:8: error: implicit declaration of function 'slim_prepare_txn'; did you mean 'slab_prepare_cpu'? [-Werror=implicit-function-declaration]
>       ret = slim_prepare_txn(sctrl, &txn, &done, true);
>             ^~~~~~~~~~~~~~~~
>             slab_prepare_cpu
>     drivers/slimbus/qcom-ngd-ctrl.c: In function 'qcom_slim_ngd_notify_slaves':
>>> drivers/slimbus/qcom-ngd-ctrl.c:969:11: error: implicit declaration of function 'of_slim_get_device'; did you mean 'slim_get_device'? [-Werror=implicit-function-declaration]
>        sbdev = of_slim_get_device(&ctrl->ctrl, node);
>                ^~~~~~~~~~~~~~~~~~
>                slim_get_device
>>> drivers/slimbus/qcom-ngd-ctrl.c:969:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>        sbdev = of_slim_get_device(&ctrl->ctrl, node);
>              ^
>     cc1: some warnings being treated as errors
> 
> vim +862 drivers/slimbus/qcom-ngd-ctrl.c
> 
>     839	
>     840	static int qcom_slim_ngd_get_laddr(struct slim_controller *sctrl,
>     841					   struct slim_eaddr *ea, u8 *laddr)
>     842	{
>     843		DECLARE_COMPLETION_ONSTACK(done);
>     844		struct slim_val_inf msg =  {0};
>     845		struct slim_msg_txn txn;
>     846		u8 wbuf[10] = {0};
>     847		u8 rbuf[10] = {0};
>     848		int ret;
>     849	
>     850		txn.mt = SLIM_MSG_MT_DEST_REFERRED_USER;
>     851		txn.dt = SLIM_MSG_DEST_LOGICALADDR;
>     852		txn.la = SLIM_LA_MGR;
>     853		txn.ec = 0;
>     854	
>     855		txn.mc = SLIM_USR_MC_ADDR_QUERY;
>     856		txn.rl = 11;
>     857		txn.msg = &msg;
>     858		txn.msg->num_bytes = 7;
>     859		txn.msg->wbuf = wbuf;
>     860		txn.msg->rbuf = rbuf;
>     861	
>   > 862		ret = slim_prepare_txn(sctrl, &txn, &done, true);
>     863		if (ret)
>     864			return ret;
>     865	
>     866		wbuf[0] = (u8)txn.tid;
>     867		memcpy(&wbuf[1], ea, sizeof(*ea));
>     868		ret = slim_do_transfer(sctrl, &txn);
>     869	
>     870		*laddr = rbuf[6];
>     871	
>     872		return ret;
>     873	}
>     874	
>     875	static int qcom_slim_ngd_exit_dma(struct qcom_slim_ngd_ctrl *ctrl)
>     876	{
>     877		if (ctrl->dma_rx_channel)
>     878			dma_release_channel(ctrl->dma_rx_channel);
>     879	
>     880		if (ctrl->dma_tx_channel)
>     881			dma_release_channel(ctrl->dma_tx_channel);
>     882	
>     883		ctrl->dma_tx_channel = ctrl->dma_rx_channel = NULL;
>     884	
>     885		return 0;
>     886	}
>     887	
>     888	static void qcom_slim_ngd_setup(struct qcom_slim_ngd_ctrl *ctrl)
>     889	{
>     890		u32 cfg = readl_relaxed(ctrl->base +
>     891					 NGD_BASE(ctrl->id, ctrl->ver));
>     892	
>     893		if (ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN)
>     894			qcom_slim_ngd_init_dma(ctrl);
>     895	
>     896		/* By default enable message queues */
>     897		cfg |= NGD_CFG_RX_MSGQ_EN;
>     898		cfg |= NGD_CFG_TX_MSGQ_EN;
>     899	
>     900		/* Enable NGD if it's not already enabled*/
>     901		if (!(cfg & NGD_CFG_ENABLE))
>     902			cfg |= NGD_CFG_ENABLE;
>     903	
>     904		writel_relaxed(cfg, ctrl->base + NGD_BASE(ctrl->id, ctrl->ver));
>     905	}
>     906	
>     907	static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
>     908	{
>     909		enum qcom_slim_ngd_state cur_state = ctrl->state;
>     910		void __iomem *ngd;
>     911		u32 laddr, rx_msgq;
>     912		int timeout, ret = 0;
>     913	
>     914		if (ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN) {
>     915			timeout = wait_for_completion_timeout(&ctrl->qmi.qmi_comp, HZ);
>     916			if (!timeout)
>     917				return -EREMOTEIO;
>     918		}
>     919	
>     920		if (ctrl->state == QCOM_SLIM_NGD_CTRL_ASLEEP ||
>     921			ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN) {
>     922			ret = qcom_slim_qmi_power_request(ctrl, true);
>     923			if (ret) {
>     924				dev_err(ctrl->dev, "SLIM QMI power request failed:%d\n",
>     925						ret);
>     926				return ret;
>     927			}
>     928		}
>     929	
>     930		ctrl->ver = readl_relaxed(ctrl->base);
>     931		/* Version info in 16 MSbits */
>     932		ctrl->ver >>= 16;
>     933		ngd = ctrl->base + NGD_BASE(ctrl->id, ctrl->ver);
>     934		laddr = readl_relaxed(ngd + NGD_STATUS);
>     935		if (laddr & NGD_LADDR) {
>     936			/*
>     937			 * external MDM restart case where ADSP itself was active framer
>     938			 * For example, modem restarted when playback was active
>     939			 */
>     940			if (cur_state == QCOM_SLIM_NGD_CTRL_AWAKE) {
>     941				dev_info(ctrl->dev, "Subsys restart: ADSP active framer\n");
>     942				return 0;
>     943			}
>     944			return 0;
>     945		}
>     946	
>     947		writel_relaxed(DEF_NGD_INT_MASK, ctrl->base + NGD_INT_EN +
>     948					NGD_BASE(ctrl->id, ctrl->ver));
>     949		rx_msgq = readl_relaxed(ngd + NGD_RX_MSGQ_CFG);
>     950	
>     951		writel_relaxed(rx_msgq|SLIM_RX_MSGQ_TIMEOUT_VAL, ngd + NGD_RX_MSGQ_CFG);
>     952		qcom_slim_ngd_setup(ctrl);
>     953	
>     954		timeout = wait_for_completion_timeout(&ctrl->reconf, HZ);
>     955		if (!timeout) {
>     956			dev_err(ctrl->dev, "capability exchange timed-out\n");
>     957			return -ETIMEDOUT;
>     958		}
>     959	
>     960		return 0;
>     961	}
>     962	
>     963	static void qcom_slim_ngd_notify_slaves(struct qcom_slim_ngd_ctrl *ctrl)
>     964	{
>     965		struct slim_device *sbdev;
>     966		struct device_node *node;
>     967	
>     968		for_each_child_of_node(ctrl->dev->of_node, node) {
>   > 969			sbdev = of_slim_get_device(&ctrl->ctrl, node);
>     970			if (!sbdev)
>     971				continue;
>     972	
>     973			if (slim_get_logical_addr(sbdev))
>     974				dev_err(ctrl->dev, "Failed to get logical address\n");
>     975		}
>     976	}
>     977	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
