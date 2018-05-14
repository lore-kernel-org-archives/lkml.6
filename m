Return-Path: <s.nawrocki@samsung.com>
X-Google-Smtp-Source: AB8JxZrBk/3efjStdoaIeQ2JrCIakA2tMQg6dkg/urE++LgGgtOPGUAbwLoQMdhTYDPWHpHP9q2W
ARC-Seal: i=1; a=rsa-sha256; t=1526301645; cv=none;
        d=google.com; s=arc-20160816;
        b=hAaKpyh9SLEiPaR2KThRCnJSXNm8zBVsx7T1QS3568QcDhrOXMRO36awrRodNlT/0x
         esi1ZYo7m3LrCsluNeESI7wWa1ggJz2HRpLoOWZAyrue/HKIJC7xy6cvoKzrRoDbUO02
         U9gQnUZGw7jKEty7FvgOdYO3WYwgUvIqon49BuPpQrqO5xixL+8n+k7TMFVFy44r6uQ7
         vKzPjYF9GhVQjJfrtJfw7ApL+UBBCCr4SFwhYsOPrXrna6HClraMFRH7keae7a4keX1S
         r01tGAjCdgSns8aT/1852fQOBWTq30yIt8vPKHW+l1dlo10QScdNC/oaer/azwJ0CQdY
         EkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:cc:to
         :subject:dkim-signature:dkim-filter:arc-authentication-results;
        bh=ThIgqfzFIx/WGQk/GvMMw+K26mhRQ/IaeW6a+cP6bQ8=;
        b=LXnk11cdeKQmFpURohpuJgNsQSrXeQKKtmvQB2lia7suATR4LpxRJ8vC1x0rAAgcA8
         mnZL6f8bTXeprCavMLkVU8HFCalI0G3XxaLlr2fZ9l9wg3gC4VMTmGNZ/o0DrScuvLl5
         riMikUuZw9TVpiAj7bAWvl6IQdqFbFUkltEoY9TKC0ccxbM4WaaZpxY5adcfS7c9Ndb3
         iUOUElKMJ2I/X+u+lMmWdqy4zfHijG8dVGnH1Y2V+hMboxi++zAV4L4dZ5D1dKPg1mhk
         ue98EVRoD+2mMlWtARQ61RzzF+4qDHvfZWoIWWQv09N9oLfGsM59E5NuZCZrbf40gBV8
         buug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=iJXsUTCA;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=iJXsUTCA;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514124043epoutp018de669d38f14f235f8c3d287257b926d~ug0ImyENw1043410434epoutp01Z
X-AuditID: b6c32a47-bdfff70000001011-3b-5af983caa03f
Subject: Re: [FAIL bisect] Sound card probe error
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrzej
	Hajda <a.hajda@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <4c61c422-a036-8fec-1153-d612fe5df878@samsung.com>
Date: Mon, 14 May 2018 14:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7bCmue6p5p9RBqff8lncWneO1WLqwyds
	Fs2L17NZTLo/gcXi/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y27xeMVbdovja8MduD0W73nJ
	5LFpVSebx51re9g89s9dw+6xeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGU8PfWBqeAH
	c8W91S4NjBOYuxg5OCQETCTOTBHrYuTiEBLYwShx68MFZgjnO6PEowPzgBxOsKJpS7pYIRIb
	gBJH10E59xkl5u2YAVYlLGAo8ftTAyOILSKgKXH973ewImaBHcwSE249YgdJsAEV9R7tAyvi
	FbCTaLjdwwZiswioSkxpOgdmiwpESDQ9/8kOUSMo8WPyPRYQm1MgWGLXt1VgvcxAC158mcQC
	YYtLHLt/EyouL7F5zVuwHyQEvrNJnFy/gg3iBxeJxX9uMELYwhKvjm9hh7ClJZ6t2ggVr5bo
	bOtih2huYZT4M+0SVLO1xOHjF1khNvBJdBz+yw4JPV6JjjYhiBIPifbLm5ggwo4SR46LQkJo
	AZNE95QfLBMY5WYh+WcWkh9mIflhFpIfFjCyrGIUSy0ozk1PLTYqMNYrTswtLs1L10vOz93E
	CE5GWu47GLed8znEKMDBqMTDG7D8R5QQa2JZcWXuIUYJDmYlEd7dRj+jhHhTEiurUovy44tK
	c1KLDzFKc7AoifOuUfoaJSSQnliSmp2aWpBaBJNl4uCUamA0esm+7PBh94gDAgb1J5V7BSYu
	eRT0OGALw7m0KKXlq12bM+R4dhw8w7L9xLzP2WuF91y1drubO0XvxVTDo4t7z5QwxLMGOOWK
	ehp9cljGIL9w8WwbrQWyn6oSbeZPjO6I/rNbIHcx//XFZ0LK7vI8LJ3mxv44Vlr8vbD/Bufg
	D01pET3OoWpKLMUZiYZazEXFiQBDJ2kZQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e+xoO7J5p9RBt/eSVrcWneO1WLqwyds
	Fs2L17NZTLo/gcXi/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y27xeMVbdovja8MduD0W73nJ
	5LFpVSebx51re9g89s9dw+6xeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGU8PfWBqeAH
	c8W91S4NjBOYuxg5OSQETCSmLeli7WLk4hASWMcosfjOC2YI5yGjxL9f28CqhAUMJX5/amAE
	sUUENCWu//0O1sEssItZ4uvza1Dti5gkVt/fzQZSxQbU0Xu0D6yDV8BOouF2D1icRUBVYkrT
	OTBbVCBC4t75T2wQNYISPybfYwGxOQWCJfqm7wSKcwBtUJeYMiUXJMwsIC5x7P5NRghbXmLz
	mrfMExgFZiHpnoXQMQtJxywkHQsYWVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgRG
	z7bDWv07GB8viT/EKMDBqMTDG7D8R5QQa2JZcWXuIUYJDmYlEd7dRj+jhHhTEiurUovy44tK
	c1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTDyfphWeCLh1dN4D4catZWlzw4F
	plgv4nf+t+1XoGqsaMUN3eN3HWrW5pfMePdG1Trp69W7vWLdr/IzQzQ63B6tTuB8HrTBPj6n
	JbpUeHd7U5LBXZYnbJJdK/+Hn4j0EWkS+rlnOsvjfuV7tm/NdA/9PiASxnlxi/g3f79S7x1F
	12q5dhntf67EUpyRaKjFXFScCADOvmDamgIAAA==
X-CMS-MailID: 20180514124041epcas2p2c17c76ad9faa3f3e6b56adb36fe8c8a6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
X-RootMTR: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
	<CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
	<b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
	<CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600443274751811362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 02:29 PM, Krzysztof Kozlowski wrote:
> Ah, I missed these messages because I was looking at err dmesg level
> (and for some reason these are warn). Anyway do you have any thoughts
> how is it connected with missing Odroid XU3 sound card and max98090
> codec?

One reason is that the DRM driver registers an ASoC codec object which
is required for the sound card registration to complete. But I wonder
why there is no any error messages related to this.

-- 
Regards,
Sylwester
