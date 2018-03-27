Return-Path: <oberpar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvhVZTIXxDbtZT0oev5wL4LRSh+7Udwp0d6D/cA3M5Za12ap25z5eNAIZAfJAm5FNSM8anc
ARC-Seal: i=1; a=rsa-sha256; t=1522141933; cv=none;
        d=google.com; s=arc-20160816;
        b=LIjU9xaRWtXj4DDKi/kwNJGqQCZtqwpi7D90YmFNoL+Tlq6k5cJ9as5Gdek8U8fHv6
         +aiVHS/SUxAA4iMhZzC0IxXah2lFFAFWzZEm2xbBwS8ZJAzVG39Ly3gj3CJ0MvhkTMOz
         YdMMI60ujGVAKZw981aneJPLamrrRPeJXTRpCx8Ke4dCngo6D5xdHwK/twsGmstWah+9
         76DCAar68dbdJlLkRy/e4IPG7QhSQZK6UEfiK3soN7yWxx64wJc4hihTOkfC8a+vubwC
         8AFTp24uqP48smU44DepVHJQThBOmjB+AWcpiD7QvLN79Qx7FviIP8LS6TiBI8wliSU0
         ofTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+5wg/E/Hs9YLHh2Po/L81tJprxShvP8dWWcjaec0qIs=;
        b=KmJsUpqpvBhZ6yc8r64Uyh8rGa/4VOYGWKKmdwDlq0DXiLl07UAPJGbyioyiD7OfiR
         xBQMHPhODdJrMXojkgOAebq+zhmuTT/poUKUBX9VCqcjSN+g/zl7RV5/YzX5sA/caaL3
         Q0gJLkIQCV+M8PMWZEFn9bwNsHkHVIYViTUego45LdfCXQx0coNUVvOfGd0vphcYe3ni
         MO3VdAPmf1Rg07MtY5LsKhWhZYpACBLa6i0IeeqFg406YHKM87X+/9b6/b8I0bceFmPP
         XXPcX38JkXnQFL2bwxP2pRveMmsG0IqNLJO8mytTUUU8WoEd9UU9v5zgRsdKBDhTrkHp
         uc+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of oberpar@linux.vnet.ibm.com) smtp.mailfrom=oberpar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of oberpar@linux.vnet.ibm.com) smtp.mailfrom=oberpar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 15/21] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann
 <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez"
 <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-16-git-send-email-yamada.masahiro@socionext.com>
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 11:12:06 +0200
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-16-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032709-0040-0000-0000-000004275B18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032709-0041-0000-0000-0000262A7241
Message-Id: <4b423f15-fa71-d51c-9362-942ba26c0fe6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270096
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545713412850?=
X-GMAIL-MSGID: =?utf-8?q?1596081500511895788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.03.2018 07:29, Masahiro Yamada wrote:
> CONFIG_GCOV_FORMAT_AUTODETECT compiles either gcc_3_4.c or gcc_4_7.c
> according to your GCC version.
> 
> We can achieve the equivalent behavior by setting reasonable dependency
> with the knowledge of the compiler version.
> 
> If GCC older than 4.7 is used, GCOV_FORMAT_3_4 is the default, but users
> are still allowed to select GCOV_FORMAT_4_7 in case the newer format is
> back-ported.
> 
> On the other hand, If GCC 4.7 or newer is used, there is no reason to
> use GCOV_FORMAT_3_4, so it should be hidden.
> 
> If you down-grade your compiler GCC 4.7 or older, oldconfig/syncconfig
> will display a prompt for the choice because GCOV_FORMAT_3_4 becomes
> visible as a new symbol.

Looks sane to me.

Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
