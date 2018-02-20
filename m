Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x226OSQTVrz1tvStjO3etluT97k8saAqFmPNqeJlZ+/SaDnMxR7i5jfyx/07a3CDlpSZIpmtm
ARC-Seal: i=1; a=rsa-sha256; t=1519170915; cv=none;
        d=google.com; s=arc-20160816;
        b=Od6fHnzkYPgSYwow3vIs6TZmBBbo99+DwGQ6qbhINDsOhCPk/eQiUEHwuZGgSrS/dM
         55DsxSvszBMUU5XkXWHDzF8BHwLC6tpCFqZczFx89peQFmb9pSIYVMMVBcxDTu/Rvmp0
         z9XTXbYbKV2Buwn75L7w2aqVlNIS3cVnm36zE4EFptIFmVB+5HMIGpWThS23A9QEabP+
         oJtpq8kyAFOWImIsQac2s3mHhc8R7da7ZZ3BmqKYUIcXJ4OnPryACu1eoOHcOUPTqMx+
         II5QFX7Qn3HDcPbb/orHlhUV8F1pFb6Rzc9s4c5jmnZGZyuuspBK2LfW/1dY64qKnUuB
         EjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=VPbTosYH9peAy7Cmn/otQ2LgYsDnMPmUowOSZfcH1AQ=;
        b=e9hKJqPJB0DFP/zKHRexmNN+36sNPKH/+f8CJHEyF+Jkj0RUj/0qb2IuHetaO4aJHu
         ZkgNrhXXUG7W4MOE3zrN0kAipJvRhfn+nG+Zl3TuuOVoDUeydfGXIeJ/npemsxYAQAvC
         qnjYue+rFB2dMek3Kz65YM+qS1MPDqfVAbOjwGDQabrer3leRpGLaFPdTl5fUdFG+uAq
         PoL6INhAAUkAePn9iDLkuEJSin1RzJEXaePTfhNp7iLtxmrMTB3XXDLl6A6LXMkDJVoy
         iC3d+j2VZ2/xwj23KUc4nQ/SIHRdPj7JXMN+ee8Ez83nFzSBWIPLd553QZVo0U2hynKK
         zZtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.141 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.141 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1960:1963:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6742:7653:7903:10004:10400:10848:11026:11232:11473:11658:11914:12048:12050:12296:12438:12740:12760:12895:13255:13439:14096:14097:14659:14721:21080:21611:21627:30029:30034:30054:30091,0,RBL:85.4.153.126:@perches.com:.lbl8.mailshell.net-62.8.60.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: road95_846c1b1f7a311
X-Filterd-Recvd-Size: 4073
Message-ID: <1519170907.4326.17.camel@perches.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,  Mark Salyzyn
 <salyzyn@android.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
 <thierry.reding@gmail.com>
Date: Tue, 20 Feb 2018 15:55:07 -0800
In-Reply-To: <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1592966161964531003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
> 
> Instead of open coding that each time introduce %ptR[dt][rv] specifier.
> 
> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.

Not sure this is a great option.
Not just the name, the need to select it.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> +static noinline_for_stack
> +char *date_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +	int year = tm->tm_year + (r ? 0 : 1900);
> +	int mon = tm->tm_mon + (r ? 0 : 1);

What happens with negative values?
Perhaps these temporaries should be unsigned int.

> +
> +	if (unlikely(v && (unsigned int)tm->tm_year > 200))
> +		buf = string(buf, end, "****", default_str_spec);
> +	else
> +		buf = number(buf, end, year, default_dec04_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mon > 11))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, mon, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mday > 31))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_mday, default_dec02_spec);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{

Maybe use unsigned int temporaries here too for hour, min, sec

> +	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_min > 59))

leap seconds are allowed in the struct

> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_min, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_sec > 59))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_sec, default_dec02_spec);
> +
> +	return buf;
> +}
> 
