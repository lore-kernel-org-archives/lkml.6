Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoN4A9rFoa7JgNohDSTQU8iow4wM6Qab0xkIg5gle38S1CejYRBTSiyJgYdhr5yW7lNYJ7V
ARC-Seal: i=1; a=rsa-sha256; t=1526666155; cv=none;
        d=google.com; s=arc-20160816;
        b=RaEe0kALj+5npdNItOa+szN91yK4PRAkb2gsihQCgFUDKXCDlrrUqWjaZXhAiup/bt
         WlfSWFu8ASoJWI854bYOT1993roKJhYvMfTIELwtNa7UHAft963GOwlTONm8PNg7FYRQ
         7IJ7d4fPpQPtvhQ2J5uzK1Q9Qrt3mZ+MVQbLFF2+vyO3xx3YpNGBlePIZrE+Iky9zeCr
         WE5+P3XYqVlOU9a3Onx1aHJugOjIHjlebm1I1/GH/ScfKquCxkJCHQIbiEQwOtP+xPK4
         9Yst1Jof/aLCfwwoAJSS4udK2iz8HH+KUSKBcZhD8CMzRtNVmXYrnKuD5etEpfTBEold
         15/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=WtYPgqJTJGWFe+92TVR8voWfkbn9JJD9YukTAHT7aKs=;
        b=q7Kiogso3W9ZqLp3WSs5lLSNA0ggpQBU3P+A0SbSSWTGLQ7xH5icr+4OX1XLJ7Xz6H
         l5G9YOQdoCFqQu+5BqSrDcFGf8GT7RapoHQRB8yT/ijZWKut2R2DwfAaqun84K57GrHt
         JMjY05Xp14Za0LL/zZwiEE21H9ARadFEb5WMAQrFjq9YdfNZIvVWOs19Wk2AgkoCwBns
         RJfWqyJEfEZOIyC/65547DDiSZHgbjiy2q0I5iBxPl5Rx4iRTSdIUzJtBiJz0ptC+OeD
         i1pVm4O1sLH0IAqbZ+XzgbjsQLW7Cbf2LMY7djs31yluB1icov0NufWt9O3GR3fUOKYm
         +jAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>,
        "Eric W. Biederman"
	 <ebiederm@xmission.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R
 . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres
 Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Date: Fri, 18 May 2018 13:55:33 -0400
In-Reply-To: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	 <87y3ghhbws.fsf@xmission.com>
	 <alpine.LRH.2.21.1805190303100.26396@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051817-0040-0000-0000-0000045AF81B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051817-0041-0000-0000-000020FF3A38
Message-Id: <1526666133.3404.67.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180191
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600825490993096475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-05-19 at 03:13 +1000, James Morris wrote:
> On Thu, 17 May 2018, Eric W. Biederman wrote:
> 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > Nack on this sharing nonsense.  These two interfaces do not share any
> > code in their implementations other than the if statement to distinguish
> > between the two cases.
> 
> Hmm, it's not even doing that.
> 
> There's already an if(!file && read_id == X) { } check and this is another 
> one being added.
> 
> > If we want comprehensible and maintainable code in the security modules
> > we need to split these two pieces of functionality apart.
> 
> All ima_read is doing in both the old and new case is checking if there's 
> no file then if it's a certain operation, returning an error.
> 
> To echo Eric and Casey's suggestions, how about changing the name of the 
> hook to security_kernel_read_data() ?

Thanks, James.  Somehow I missed this option.  Renaming the existing
hook, would be the easiest solution.  Eric, are you in agreement with
James' naming suggestion/solution?

> Then ima_read_file() can be changed to ima_read_data(), and then instead 
> of two if (!file && read_id == X) checks, have:
> 
> 	if (!file) {
> 		switch (read_id) {
> 		}
> 	}
> 
> 
> 
> 
