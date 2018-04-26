Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524744341; cv=none;
        d=google.com; s=arc-20160816;
        b=k+EFfYL23C8p2hJn8Pfr63JvagHvjx46Y81R/nZb/bptU6QBIGPMg9fiyTU8EFTJ1n
         9+4BuSA15oxjP3GM1c0BFstNdAxe2SW/0WkIWHMVSnRYPWJq8EpwrNYN5fdgqAmUCPWl
         VRoF8EQ5tZhohRd8dR59boIFWpU63zzibHYIrRIqRweMvulD/7zH/6rPyMNYsCekLRfp
         T9s50O526qbzAVOD4RBa08wSo913Lw6SFY12Kz2/LArldc1sqIhjMqWAoMNhY9VYspai
         PDZpKfeP8jjIw09XgRCM+yJEcZsJjcp98g/06sWBcmgxq2qIX0gIJyFoc92XLdK9m9oA
         U7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gVgkSl4z2AnQrm4n83DgWxZxgD8h5F/W46ZnbKGZRhM=;
        b=Oto6IR//WMtJRWWPwlQs/pAdkheSfiRm5hkLIWdwPNHWIRvRwNyVf9g/yRAI+QXo80
         4pIYCUbXJ9wn0vRBYuMn57cSzH57LrVrCRlLMBAk8e1Xk9Ox0JOkQeM1GLYvd/m8jBeI
         Us7y5iWjQp1ZjaXk/YVWcrCyYRB6PieAkXK4kfqRqs3gWEWUIuNSGNG1LQdjE7a/OSTI
         lxOSew7GFwp5WhyLS5xKfoPIerT8g1Px6SxtorL0sYtAbiqeUiwLIoEZYnKX7iIgtGL0
         4NqU3G0byzdRiIEU9DSgLDev8U4HdX3K3ehyN2hfe+VxkWl2JQTdqiln89QGsbZFbC6J
         EvHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ViEFiHrG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ViEFiHrG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/Eqt6FmDTzeUVGhsjOFh7Ve1VzTIjjO3X57vVchq5BvPiJouX6ocl4kTQTtX2badEkclFigA==
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org,
 gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <35bf7a17-8d76-285f-987b-bf74e2b8e5b8@linaro.org>
Date: Thu, 26 Apr 2018 13:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180426113911.GA21755@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598810322609818075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 12:39, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
> 
> What is the plan for getting this patch merged?  I think the only review
> I've seen from maintainers thus far has been from Rob on the DT binding.
It was initially reviewed by Bjorn and Rohit. I requested Andy to have 
quick look at this.

I was hoping that APR driver would go via Andy's ARM patches. And the 
rest via your tree.

"depends on QCOM_APR" should prevent drivers from building without apr.

> It's obviously going to be a dependency for everything else.
> 
> Also just saw ARP->APR there.
I will fix that!
> 

--srini
