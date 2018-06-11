Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xJrPLEuDHlteEwAAmS7hNA
	; Mon, 11 Jun 2018 14:13:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A50B1607BB; Mon, 11 Jun 2018 14:13:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A732360351;
	Mon, 11 Jun 2018 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A732360351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933669AbeFKONJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:13:09 -0400
Received: from mx1.emlix.com ([46.4.235.150]:56754 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933646AbeFKONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:13:00 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C37BF25F5B5;
        Mon, 11 Jun 2018 16:12:58 +0200 (CEST)
Received: by mailer.emlix.com
        id 1fSNZ5-0005uG-7E; Mon, 11 Jun 2018 16:12:59 +0200
Subject: Re: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>
References: <20180608101924.31195-1-pp@emlix.com>
 <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
From: Philipp Puschmann <pp@emlix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pp@emlix.com; prefer-encrypt=mutual; keydata=
 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
 nkFFRXn8
Message-ID: <40261c5f-285f-66f3-41dc-7107c487a47e@emlix.com>
Date: Mon, 11 Jun 2018 16:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Philipp,
> 
> On Fri, Jun 8, 2018 at 7:19 AM, Philipp Puschmann <pp@emlix.com> wrote:
>> q/dl datasheets list the 5th selection value for ck01_sel as
>> video_27M_clk_root.
>>
>> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
>> as parent for IMX6QDL_CLK_CKO1_SEL.
>>
>> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> 
> You could still have added my Reviewed-by tag that I sent previously :-)
> 
> Here it goes:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Also in the future, when posting a new version of a patch, please mark
> it as such:
> 
> [PATCH v2] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
> 
> and write below the --- line what are the changes in this new version.
> 
> Thanks
> 

Hi Fabio,

thank you for your hints, next time i will do it that way
