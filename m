Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDCQBB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:01:01 -0400
Received: from smtp37.i.mail.ru ([94.100.177.97]:36416 "EHLO smtp37.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeDCQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:01:00 -0400
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
To: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
Date: Tue, 3 Apr 2018 19:00:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403155224.GA11578@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp37.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A521CF74858968C1FA24F7F11A85DFF40117C3D9B8D07C2777725E5C173C3A84C30584FF81F342DA07130BDA849125FBD6A91E23F1B6B78B78B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917E8CBD4EE5B0A9065ABD080F4C3DE7A92069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 06:52 PM, Mark Brown wrote:
> On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
>> As long as sun4i/sun6i SPI drivers have overriden the default
>> "wait for completion" procedure then we need to properly
>> handle -ETIMEDOUT error from transfer_one().
> Why is this connected to those drivers specifically?

These 2 drivers have their own "waiting" code and not using the code 
from SPI core.
