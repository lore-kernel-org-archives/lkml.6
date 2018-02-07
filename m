Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbeBGQ1V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:27:21 -0500
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:37920
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754231AbeBGQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:27:19 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chad.Dupuis@cavium.com;
Date: Wed, 7 Feb 2018 11:26:43 -0500 (EST)
From: Chad Dupuis <chad.dupuis@cavium.com>
X-X-Sender: cdupuis@administrators-MacBook-Pro.local
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Saurav Kashyap <saurav.kashyap@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] scsi: qedf: use correct strncpy() size
In-Reply-To: <20180202131225.1658853-7-arnd@arndb.de>
Message-ID: <alpine.OSX.2.00.1802071126080.1466@administrators-MacBook-Pro.local>
References: <20180202131225.1658853-1-arnd@arndb.de> <20180202131225.1658853-7-arnd@arndb.de>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Originating-IP: [100.0.162.75]
X-ClientProxiedBy: CY4PR16CA0026.namprd16.prod.outlook.com (10.171.216.13) To
 BN6PR07MB2771.namprd07.prod.outlook.com (10.173.27.145)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d53cfa-c09c-4968-19bb-08d56e47a5b6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR07MB2771;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2771;3:xA0D6tXIBXvLTLXS57UhL7Kpb7yst1FmkHxNr6mjYZ26+rDFS7+PHf6H2mx35xWXNQcHXWVAO4UXxXJveextJR5/lVehd8ZHL9BQeV+R7zULK7tKfmSqFlbJm50D0oYfAaGr0AraaVkCBVWQwVDWdpBR20CYMt8gwVtME45ChELdkGffSXEyAJLHrvyd+DsjZQC1wb0AO0InhyNG5OQajRWXCuhKaRa0Vhl7asIqjEyFZO6gECahN7b7gFLbG1Pu;25:lSSHll9w9hY2zSlaCSZFXYUH/MJik847QMZiibOmfZqTQcu6TENBefZDjcEIhmZK//aqD8hAFO5z9AxTzylNSM+RQ4/J6PBdxGXuRGwooxr2XMUBonN1nt3O80yuu0h+563/pIVUn+QVr2ZxwVFkqMeNQ2SqbrQYd9paA8PqOqBkVNzcxURl2ZqYddOIp7tA+Hpf4UR9zkybimK46oNz2SDl7IWPdv26DjzBfIp0+bat/kQ9AxLFAQ3HfMEzc2XziThU6nQsmN3kZHd6WcX12Fz886V1THxeX4R/1/UEh9jiLU/laTcbrKew0g0zkjec1RnMAk3iFKO+inOyzxB1Cw==;31:h1sGvMhLogeZeZKktn/a5fCrkMahVHWoyzZRBoAHw/TMtgaMLjJXqlH0Q0XzLOJdMj4ludNUCbLc+P7lMdblZ6X0yNPrC1EL6ldcSbuY64Qu4jsPKawI/Q5qO11AsqwnKhbEUKjJRgINqEJzapub7RiAJAxg5FnRS/sSaO7eyvp0GkjI4vQ6fLwXuhfJVywjcc3Sv8kPK7Sq//6QYF6s6EozKw8sx/NzI4uyW08zh3c=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2771:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2771;20:2JWGMJafsfwmKXP2T1wua72LfXSJje94vH7+tu9ABbGc1luOAIbfU976ToJJI1BJGYLwPb5snVyf6UZt35XLXjPfvS/sMnCh9ofvvAeTojXu5BjLLZXjPPyDoXbZhqGAQEfSSXWwfJWSCCHC6tGe2Zz9xe+yeTzauwlsl9DNGVBUsIvDhOOiTPBOaY1W5zFodu/qq9dziYp02zzqRahIWxf30Cu2+Uqm3vA50P4CE9EGMVRtaWaZyWaOTAov/UztP0GWW6ayXlBztEx5TtNGEEinPco4FEpz8vQTf2EQhBKa43qyQb7C8QrKC1Wd3je1Lt2rKwvvwQXnwVAr32knpv3zmDHfz+nErum5H/QpQ6R4YMU0uMweOphLnl6TW2pdW9l7zLOwlZ7dEIZlIzwwlQYdxyEvIiI9zz2w6fCJ5kQe+rfCyF+3De1zUjSnJoD2Q5Qqbk8TH3Fop4TA/KU+VXTrD+A0DtkqrTp6P+l9TolZ+J/PD+No7Qi3k45R8wlo;4:8nmv0sFqg6XKGL2M59mepDztwYvjSvuW2powzOpytn1IjKyN1nkbsNHIE+OqT+mQwGp3IPex+8JVhtC2bIZFfckwOqXdrZvQrk7yDqRnkAe6U7oxNQVbz90RooaqengG41K6bP9J8gWIKo83W56Q1MOpHG08Ir7bw5Nnhm986v9p2AtqSY2uhCocItm8FWE8VfxUXhNvpBXj1jfRD9ZmBKmId82CxN7GtUu85AKCre1KMw8whOpRVQ7O9xVA9vYLmC5lXNBbtywen8VgD7E+dj4qcokdxyB522jlKFVkhRY+oXFuxks9BjnWMK4TAcEZ
X-Microsoft-Antispam-PRVS: <BN6PR07MB27714755D6080075507DF0889EFC0@BN6PR07MB2771.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR07MB2771;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2771;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(376002)(346002)(396003)(39380400002)(189003)(199004)(9686003)(53936002)(68736007)(6246003)(386003)(76176011)(33896004)(106356001)(97736004)(52116002)(4326008)(25786009)(8936002)(105586002)(16576012)(54906003)(58126008)(26005)(2950100002)(6666003)(316002)(16586007)(47776003)(59450400001)(6916009)(229853002)(66066001)(5660300001)(305945005)(7736002)(117156002)(90366009)(186003)(5005980100005)(77096007)(16526019)(478600001)(81166006)(81156014)(6486002)(83506002)(23726003)(3846002)(86362001)(6116002)(98436002)(72206003)(8676002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2771;H:[192.168.1.225];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2771;23:/MmXRodrLSRPzPofTWVObRU5x5KqN/Ga5+trg6zKQ?=
 =?us-ascii?Q?15vNrOL0IiZCh+PhLeYu8is6Uqfs5xaeMOkjgGxq9up8HSY82MCXo2W9VQ1J?=
 =?us-ascii?Q?IRSvQIksAqCG+7IlQZJhLSlvGTQOWpC9Utyd2qhDu7hRq3Y0hoKTnFNDo1Cl?=
 =?us-ascii?Q?XFWg3XN8c0HErjZyjh+G4ga8GqpFuqhS+KODckibOA4+7UQvzV5QfbxpE39Q?=
 =?us-ascii?Q?zBIs0e7f9thtES4+Ej0at8pOtYU0c26VaZOSvserKq3T6qxS+/mJA7PnMVYT?=
 =?us-ascii?Q?J23YTQ+9KoIxWjQeMMyRS0dtCde9P+h+sI2gp94kttTGjnaY4+ZJcrmTpyVa?=
 =?us-ascii?Q?IvUJY8mtRQtMrIK1vhqj1VK1BeO/PThXxVVfntEjx2MRuukqioaiL+7cbm5w?=
 =?us-ascii?Q?LpPTTuqwNqdjCjoJhj9oymzloRhMOTWCQ4dLzOfbPXt7TYH4ZLj+cgt++ov/?=
 =?us-ascii?Q?NZ9SKw13/yEqOwoVyAT+FLCkzrmkFix5AhDTFONChsvBdI3pGsYsaz6LQKrj?=
 =?us-ascii?Q?o5fNkOhtI4lSPY55WrvBC/ZInxpb63MZGpvFoAWLsPsfwUuYTQARhJwVZjff?=
 =?us-ascii?Q?zYIJ/79S/3MbeIqIw0yfunKwLLu6OxGwf/u1tTOTTTnG8Ihjor5Vt/yu2+6c?=
 =?us-ascii?Q?UaNiVxlf5Q+EjTNXfYWqSnLwp+iCDOR6OxE2hhQTBVIYsdxkc5pI1va5gh6f?=
 =?us-ascii?Q?VaDIQqxXPwQ2wZb7ff5qlqNoh0xPzIaNMlY6qn9bjlBSiUQfJdqxx6dGp3ue?=
 =?us-ascii?Q?1fAYJMHP9xZvQ/6PrAJrnGdotpnEKTVsJV+xIHFd/DLU3fj57nHDCHfGFIhP?=
 =?us-ascii?Q?im61g3OzextQzS+SGGfV0AwQrlmO4LK668XGEvrU5+3wf3CC5NvcInt2AfcH?=
 =?us-ascii?Q?X4Lg+VCTLLSfxpA98fMIpo5cNbbgFEa2Mz+O4Yg4+vJskXi1+UXvqLqpizwy?=
 =?us-ascii?Q?0oDz0A6OkVL9Q8HCNbleACkiujN/XTI+dVmDLTjQP68AXomYObh+PKy6bkZ3?=
 =?us-ascii?Q?elQ3nJPgabrkBhJNNhG5c7i31njPox6rGQPrlcUzmH25gPfQc6TNJuAawqkS?=
 =?us-ascii?Q?KIn+2mpgReo24BKp8OGiZJOHTbsJl2xgD8NZK2Ukki9laP35qoJcNXSKNutc?=
 =?us-ascii?Q?TiGOinupp7XYiP9LpBh5/DYwUueN01BxmAwEPzMZmNvKWIBlzN/LeT3F5+GR?=
 =?us-ascii?Q?iZWwGOQgoSHYuZnjO7QQxB9FgkkdV4gwlWbp4mJG60O2FgyngE00yVXpHfre?=
 =?us-ascii?Q?SRMM27NN70Ok85tKKpz35jHaTZ53gQP6VHqGNaQdykUKB8d18L16ieKiWqku?=
 =?us-ascii?Q?fl6e6j4YxAJ93iiNhmFpcx+twtSHKVQsGUfTLBHwBvZ?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2771;6:CTPOhAxQiUcYPNNRnYFwNm8oSwDsyvExwUVwgTBRFmLRXmHf0JTOiH3a9yq7EaigdR1VeFXxyItrsUAUUMdOmkGUoU8U5cOnZtYljqmNVr5lom1bYbR3BPhlWsXn1VhhcQ06OuR/C70J83re/NuFqanG9LC4BShZ0nyiuZxICYZqi3kfXk80rZozgKbYk5fPM+zhP5tIuNtM7oyYSYgcXMNvcGao0l/AvkWoYNZGTw0Ja/e4NCzYnhzN4IQckrUa+bkOSZE4jg2aQkAZSvG+OzjjYoEVC73Yuf/EfE840qTP1hXPljCuaxwR6qOl9SRoAy5onyjVBvokhuIyBIv3ajC7LnSMBx/hScMvunh9/Ko=;5:RCDXiAnRpsk7S/OuCHun507hxRSvvFAo/pXVUHjiMhiKq7XQ3HsMBvremiaPGrzqnAKAJU9w3fjYqjm3uTMUGQOrZHS7jfrKiEwrmgqAHWm0Ce47tlWRYdY5wrmnWw551wS840eVYMaA8fv3D9lxonGZiLte4tHvYWZ5rxXy1/Q=;24:ycFhheyn+qZqdOZADBQqtfL3nzdlBm672kewnQtokzQYYNOxROMMFscJh43uFeSp8kgtE+MTPIdKRL/67D4k6toWW+rWoXsTQDollN9owFU=;7:9jyeuQ4pgVELf/epjA3HsrMxlZsrjn0lunO/2BfLfPOaxKrhP+kUCfXfAGGUdV5WjXu0mouo5CfaH3ch7VJm4SAi8Jb2jENqjrXuIEyeQ3sS526a46+ayAFFdX8p/hPEdiypxWSR1oAxOtX0P3j5+6+ICDo464P/UlScNxjquc7Lkgah8K0+FWQpdMSrpDPlq23ALOXo2WJQtpWdXHMfIqtc+fD8nUCVUKdIs77OGADwe3YpehxywlwGnSmk4Hvf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 16:27:12.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d53cfa-c09c-4968-19bb-08d56e47a5b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2018, 8:12am, Arnd Bergmann wrote:

> gcc-8 warns during link-time optimization that the strncpy() call
> passes the size of the source buffer rather than the destination:
> 
> drivers/scsi/qedf/qedf_dbg.c: In function 'qedf_uevent_emit':
> include/linux/string.h:253: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
> 
> This changes it to strscpy() with the correct length, guaranteeing
> a properly nul-terminated string of the right size.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/qedf/qedf_dbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reasonable security precaution.

Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
