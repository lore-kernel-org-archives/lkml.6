Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZpk9yozwypHPa+C8Rr4ku3/ftyQg+GPkItdWOzmM8WdE5rhDxFFGStwz35RLi1uLqW36n2E
ARC-Seal: i=1; a=rsa-sha256; t=1525811250; cv=none;
        d=google.com; s=arc-20160816;
        b=zmCv8g63m5HkkNO65oD7niZjHXZrBh6daelLIk/jlhWIlB/YLkx1QAi1cTmCOzOQcE
         BWlZU3nXkqipgKL0ItIIZxKwRte5T774D09aNtcpmKKUxPATIuGL3WbpF6LPhAdhxR3u
         qsRZL6TW3f9quGoPOVkzDJthdAeDz++6lC8VYThUtEG8p/MLS7v0xi6BnaunXrXbNx6W
         W3oFQfcvQC/pjINJcA1FoX0VIQWwezNKp6wqleZ81Gqteo7Xxj4KLsjUfPkEXiljbWZ2
         TFwQzrNyRapHNKdIRWctBJiZS2fHaXOSShW4j0EzSQq9aRlx5T39LUjlazsFoUmuA07q
         JVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Wagr70+VFrpHjOlEn++qQPgx9o6vJITdjws7afP+5KM=;
        b=x5CROg0jB/Z/hA7tJzMDaWkyWjuW04tL+95yvuMVliUlVBnzxYfTwDlqOrtjqV0Swr
         NsIhft7Z8C4zLPO/djcJB5j52Jeg4/0VgvTT6Q5PlhiUOYC2Xs9O4dWLxtjF2RBBzWRr
         NsDb+gZzXr9pSr/znh9zyU9HTDulW2vwrpflw4VLqB8WG2fY2kF1q7h3eCyY2TWeJaAV
         ww48/XxU0EX+AIyeVFF5RqVA1o9ONloCLAIZsTpqqMbbG8JhkFM6oSN8LLgrGeOyIGIX
         iNulk9yqS/ueG9xvmb5G8toJ1omRYY5g94Rkj8Gkv/ItN4DGTCrBxk4Kct1bSLhqMwLN
         hgLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftests/intel_pstate: Improve test, minor fixes
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
 shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Thomas Meyer <thomas@m3y3r.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <1523398277-2066-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <00379a47-e35b-c5a3-2f94-4fa3b90921e9@kernel.org>
Date: Tue, 8 May 2018 14:27:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523398277-2066-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597398910011233262?=
X-GMAIL-MSGID: =?utf-8?q?1599929058366349862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 04:11 PM, Daniel Díaz wrote:
> A few changes improve the overall usability of the test:
> * fix a hard-coded maximum frequency (3300),
> * don't adjust the CPU frequency if only evaluating results,
> * fix a comparison for multiple frequencies.
> 
> A symptom of that last issue looked like this:
>   ./run.sh: line 107: [: too many arguments
>   ./run.sh: line 110: 3099
>   3099
>   3100-3100: syntax error in expression (error token is \"3099
>   3100-3100\")
> 
> Because a check will count how many differente frequencies
> there are among the CPUs of the system, and after they are
> tallied another read is performed, which might produce
> different results.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Applied to linux-kselftest fixes for 4.17-rc5

thanks,
-- Shuah
