Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AG47ELuIJaB+2pY8VEn4uVbs+zYp7wZY68FzC6pwVMSSzIgZ366gh6eYCGoMIa0cQUrlwStt4HTm
ARC-Seal: i=1; a=rsa-sha256; t=1519275869; cv=none;
        d=google.com; s=arc-20160816;
        b=bezt6hNfDsaTsdRnujNNCLCTagFSA7Q+7c+UpqSsA9FQLaW1Rs/hdkujc7t40tawC7
         YvcTyDUZHDWWE7y1d7Q59QmFWKEf1DS3ZYo8dUMreXXDqAa/hrPfwt7ruhQWXp1P0Sih
         OX0ZH7XxXhyRKMdHH7rYvv5ZGIkfipvUp2dAO8RtJulTQOMCJ6fU+1G68LU8AT5bYT5n
         AZUWN4mR9zpJohP0VVEfehSwZMoGp2QgvOFJfHsqfdVnifvbcUOCoXxRzUoHa1mgMR92
         um+6oxagSQDc8hR9furtDr18mcpOZyUq+wH5xm68Wrej2sItm7jevoyG+9Wd2rN8IqER
         PI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=WJIFLW9nQI1gOtjlftkPY7GzuPO9/KbuRaFFkagnO7A=;
        b=IeSn+/PthrlCsTWqpc6+sPEbj+EoxdYixOsNccl1CNbyWqZPnAZzuVEXbpRnZxsYQq
         2mrWHcJpIG2gBrPd0Rd1volfEc0af7e8ZoDaCKxlxqtCiWW2hl32XVIywZElITXngHZe
         HVtYsW3b5JjSA/GW4Cpeagkqekqbo2Gwi3uA3wDE+y7UDQtYSbDOsNUDwBSFK8n0JgVv
         KtLzO9Vt2rVHwVqQ0XjSs4cIveLOqI8K7KAEafs2sJoBhpQ0ngdHwurd4LiEKG1+k6lG
         BFWDphdqYv4Wzlq88u5o8CWSsoBM+BXCKjeCb95SEQQOXBOqfbZgCaAMtRl5qIdtpSd2
         /p7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 21/23] gcc-plugins: move GCC version check for PowerPC to
 Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Emese Revfy <re.emese@gmail.com>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Sam Ravnborg <sam@ravnborg.org>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-22-git-send-email-yamada.masahiro@socionext.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 16:04:21 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518806331-7101-22-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022205-0040-0000-0000-000004365670
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022205-0041-0000-0000-000020D86DA7
Message-Id: <6805fb77-23b9-7880-13f1-5d082d5c1599@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220065
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583966587160567?=
X-GMAIL-MSGID: =?utf-8?q?1593076214476481420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/02/18 05:38, Masahiro Yamada wrote:
> For PowerPC, GCC 5.2 is the requirement for GCC plugins.  Move the
> version check to Kconfig, and remove the ugly checker.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

The old checker was as non-ugly as I could make it. :)

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
