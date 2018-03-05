Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeCEIaw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:30:52 -0500
Received: from mout.web.de ([212.227.17.11]:43389 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932600AbeCEIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:30:43 -0500
To: linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Don Brace <don.brace@microsemi.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] SCSI-HPSA: Adjustments for hpsa_big_passthru_ioctl()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:30:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VVOM0AJlIGw8uF/NYC8MN/A6DJ+US+XNsWEOrcd0DJ6wwEKjNDs
 HcZQfkOFrx8uuSDSUGokX+iFrGoch+/6aqLlyi0WjpMQsCW8HtoEybNJzSEk+rUSUp66p8u
 GzLi+21mo2Qa8yBPFvsVGuQ5NBsjA6zCfrLBl/mYRlpV1KdN5lIg8fb5CPn0NUMmFOll+9i
 FHqmpfILKnZMreNb1qK7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pGq5Owz660w=:EK7GV0cReiyaRxytWBLh44
 vt0PICQ0yl0talzMqstLp3fZnbWyN2LY/Zuqqxo9fYPPOV7ECr6bGXGW61ieffOUDBIqUaBR5
 hNrwtSK4eih2NzCg3v+0d0urr5Nzir0pxt5PjOjNxQJzlKhhlJGpyDGZpr4eEZuEhuwcIpBE3
 +pvEIYbIgKWLrQXWIYLflfHAoNsYQZfEs1HUJeWdWe4vrsoxqtOLlMHCuYnXfqHVgz8daB93E
 NG9FO3hMGS2w/OTzs9ljlQcypDmY4fu+ew5T7SYX+2VjY17x8f7N5flXRI9f63Dz/dgoIRJzW
 zDkNz4APlOjY+VeOvI4CNcnEi6ZBY/4hJvyS8D7e7mJYHokmJsw2Rlf7ZixGUjdYV5sATfCuP
 uZ+bS94HOJGUBWPfQl9/OJ7uRwpdF8gQifn6H1qZeeMalTNOHyqW17+AiqqLeHmevSxrBLYHI
 0tF8uEik+jAQD9MxALaBGpADkqNxM1lYCLsmlQNrpJz+CFL6TxED5lB1iKPk6SyWvTIQkK5o3
 SRDzyNZt1OvhylLwQtsfxCLnjn0B06TU9AiLgaq9YCz+2B0GmiEuVcKAGbYvvTCxqtYrwuBQ1
 OKvbqMS2mIROXhXcdIBEQT4uG+QiPthGCS5HuYOMKVf55OJCSoM6Xbl8n8Z7Y8dWWKoei8n7m
 kkEaihlvxKhQ1mm4OuiF66tI9RqJWjlAf3swIjuvdU6wV+6rRu66yaq0nkPE6MrajaSUGUJIH
 HVy0HmaWJSkPJkQ5XEkOqR3cdb5UJI/yDmRFGx30h2V4d/XaSY0sq3fBrUXz1/eGHzuKe/Lye
 K8J3EJfOuKX9E4vpS3g/lbmnxtZu3/ZpXM85EmttgYr/WsjdxY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:14:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Use memdup_user() rather than duplicating its implementation
  Less function calls in hpsa_big_passthru_ioctl() after error detection
  Delete an unnecessary initialisation
  Move a variable assignment

 drivers/scsi/hpsa.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

-- 
2.16.2
