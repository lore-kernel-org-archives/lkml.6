Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aFmeDERnGFvNZgAAmS7hNA
	; Wed, 06 Jun 2018 23:04:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ED50A608BA; Wed,  6 Jun 2018 23:04:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="mvo1Kk5x"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CD796074D;
	Wed,  6 Jun 2018 23:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CD796074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeFFXEF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:04:05 -0400
Received: from services.gouders.net ([141.101.32.176]:37209 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeFFXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:04:03 -0400
Received: from localhost (ltea-047-066-034-138.pools.arcor-ip.net [47.66.34.138])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w56N3vcZ005370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 01:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528326238; bh=lKCfzJjxZ4G7hvcrfJ6IsxsRUwqIRbTNOh8irS8c7eU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=mvo1Kk5xYS3U3eiA3qfyMa0FtcJd6xCE/Rc2HBLgOJxR9w4YBZPmLwkeyd4rWXYSJ
         vrHlOpyQKJgUjCrZDGdoX5Fk1LoW4uJ/gAPEMD184zGmr/2vGPcsCmdwyGw16w69A8
         XqkflLvxFp7PMcy7QVGN9py3qCxa6EereIN10s94=
From: Dirk Gouders <dirk@gouders.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] Emacs-like isearch for mconf.
In-Reply-To: <20180606225259.GY17342@gate.crashing.org> (Segher Boessenkool's
        message of "Wed, 6 Jun 2018 17:52:59 -0500")
References: <20180606215855.12889-1-dirk@gouders.net>
        <20180606225259.GY17342@gate.crashing.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Thu, 07 Jun 2018 01:03:56 +0200
Message-ID: <ghvaavv7oj.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Wed, Jun 06, 2018 at 11:58:55PM +0200, Dirk Gouders wrote:
>> @@ -332,6 +332,7 @@ int init_dialog(const char *backtitle)
>>  
>>  	keypad(stdscr, TRUE);
>>  	cbreak();
>> +	raw();			/* Enable CTRL-sequences*/
>
> Is that a good idea?  You probably should mention it in the patch
> description, either way.

Thanks for commenting on that.  I planned to explicitely mention it in
0/1 when I coded that function call but forgot it when I finally sent
the mail.

Dirk

>
> Segher
